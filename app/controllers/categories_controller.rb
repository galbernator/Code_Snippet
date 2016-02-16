class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      categories_path @categroy
    else
      render :new
    end
  end

  def show
      @category = Category.find params[:id]
      @snippets = @category.snippets
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
  end

  def destroy
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
