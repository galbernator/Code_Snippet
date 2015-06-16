class SnippetsController < ApplicationController

  def index
    @snippets = Snippet.all
  end

  def new
    @snippet = Snippet.new
  end

  def create
    snippet_params = params.require(:snippet).permit(:title, :block, :category_id)
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
      redirect_to snippet_path(@snippet)
    else
      render :new
    end
  end

  def show
    @snippet = Snippet.find params[:id]
  end

  def edit
    @snippet = Snippet.find params[:id]
  end

  def update
    @snippet = Snippet.find params[:id]
    snippet_params = params.require(:snippet).permit(:title, :block)
    if @snippet.update(snippet_params)
      redirect_to snippet_path(@snippet)
    else
      render :edit
    end
  end

  def destroy
    @snippet = Snippet.find params[:id]
  end
end
