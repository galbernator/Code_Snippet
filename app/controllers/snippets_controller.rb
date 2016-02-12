class SnippetsController < ApplicationController

  def index
    @snippets = Snippet.where("user_id = ?", nil)
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(updated_params)
    @snippet.user_id = current_user.id if current_user
    if @snippet.save
      redirect_to snippet_path(@snippet)
    else
      render :new
    end
  end

  def show
    @snippet = Snippet.find params[:id]
    @vote = @snippet.vote_for(current_user)
  end

  def edit
    @snippet = Snippet.find params[:id]
  end

  def update
    @snippet = Snippet.find params[:id]
    if @snippet.update(updated_params)
      redirect_to snippet_path(@snippet)
    else
      render :edit
    end
  end

  def destroy
    @snippet = Snippet.find params[:id]
    @snippet.destroy
    redirect_to session_path(current_user)
  end

  private

  def updated_params
    snippet_params.merge({block: params[:snippet][:block].gsub(/[\r\t]/, "\r" => "", "\t" => "\s\s")})
  end

  def snippet_params
    params.require(:snippet).permit(:title, {category_ids: []}, :description, :is_private, :block)
  end
end
