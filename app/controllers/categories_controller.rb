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
    q = "%#{@search}%"
    @snippets = Snippet.joins(:category).
        where("(snippets.title ILIKE ? OR
                snippets.block ILIKE ?) AND
                categories.title = ?",
             q, q, @category.title)
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

end
