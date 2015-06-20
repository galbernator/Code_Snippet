class WelcomeController < ApplicationController

  def index
    @categories = Category.all.limit(11)
  end

  def search
    # TODO: consider moving this into a scope in the snippet model
    q = "%#{params[:search]}%"
    @snippets = Snippet.joins(:category).
      where("snippets.title ILIKE ? OR
             snippets.block ILIKE ? OR
             categories.title ILIKE ?",
             q, q, q)
  end

end
