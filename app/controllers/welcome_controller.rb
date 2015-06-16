class WelcomeController < ApplicationController

  def index
    if params[:search]
      @categories = Snippet.where("lower(title) ILIKE ? OR lower(block) ILIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
    else
      @categories = Category.all
    end
  end

end
