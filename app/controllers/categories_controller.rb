class CategoriesController < ApplicationController

  def show
      @category = Category.find params[:id]
      @snippets = @category.snippets
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
end
