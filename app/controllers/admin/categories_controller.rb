class Admin::CategoriesController < ApplicationController
  before_action :authorize_admin

  def index
    @categories = Category.all.sort_by{ |c| c.title.downcase}
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to admin_categories_path
  end

  private

  def category_params
    require(:category).permit(:title)
  end

end
