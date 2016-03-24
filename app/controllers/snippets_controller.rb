class SnippetsController < ApplicationController
  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    @snippets = current_user ? Snippet.not_private + current_user.snippets : Snippet.not_private
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
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
    if @snippet.update(snippet_params)
      redirect_to snippet_path(@snippet)
    else
      render :edit
    end
  end

  def destroy
    @snippet = Snippet.find params[:id]
    @snippet.destroy
    redirect_to snippets_path
  end

  private

  def snippet_params
    params.require(:snippet).permit(:title, {category_ids: []}, :description, :is_private, :block)
  end
end
