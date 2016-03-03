class UsersController < ApplicationController
  before_action :authorize, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:first_name, :last_name, :email,
                                            :password, :password_confirmation])
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @snippets = current_user.snippets
    @categories = @snippets.map { |snippet| snippet.categories }.flatten.uniq
  end


  def edit
    @user = current_user
  end

  def update
    user_params = params.require(:user).permit([:first_name, :last_name, :email,
                                            :password, :password_confirmation])
    @user = current_user
    if @user.authenticate(params[:user][:current_password]) && @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

end
