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
    @all_snippets = Snippet.where("user_id = #{current_user.id}").order("title")
    @snippets = Snippet.where("user_id = #{current_user.id}").order("created_at DESC").limit(10)
    @categories = {"HTML" => 0, "Javascript" => 0, "Ruby" => 0, "CSS" => 0}
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
