class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    all_snippets = Snippet.where("user_id = #{current_user.id}").order("title")
    all_categories = []
    all_snippets.each do |snippet|
      all_categories << snippet.category.title
    end
    @unique_categories = all_categories.uniq
    @snippets = Snippet.where("user_id = ?", "#{current_user.id}").order("created_at DESC").limit(10)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
