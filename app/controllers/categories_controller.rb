class CategoriesController < ApplicationController

  def show
    @category = Category.find params[:id]
    @snippets = @category.snippets
  end

end
