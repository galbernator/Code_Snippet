class WelcomeController < ApplicationController

  def index
    @categories = Category.all
  end

  def search
    # TODO: consider moving this into a scope in the snippet model
    @snippets = Snippet.where("lower(title) ILIKE ? OR lower(block) ILIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%")
  end

end
