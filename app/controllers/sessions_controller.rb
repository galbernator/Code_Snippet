class SessionsController < ApplicationController

  def index
    list = Category.all.pluck(:id)
    @array_of_ids = []
    list.each { |id| @array_of_ids << id }
    category_snippet_count = Hash.new(0)
    # @array_of_ids.each { |id| category_snippet_count[id] = Snippet.find(category_id: id).length }
    # @categories = count.sort_by{|k, v| v}.reverse!
  end

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
    @snippets = current_user.snippets
    @categories = @snippets.map { |snippet| snippet.categories }.flatten.uniq
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
