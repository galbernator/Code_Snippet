class UsersController < ApplicationController

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
