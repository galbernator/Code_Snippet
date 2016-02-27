class CategoriesController < ApplicationController

  def index
    @categories = Category.all.sort_by{ |category| category.title.downcase }
  end

  def show
      @category = Category.find params[:id]
  end

  def search
    @category = Category.find params[:id]
    @search = params[:search]
    @snippets = Snippet.not_private.with_category(@category).search_for("%#{@search}%")
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

end
