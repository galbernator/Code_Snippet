class WelcomeController < ApplicationController

  def index
    @categories = Category.all.limit(11)
  end

  def search
    @search = params[:seach]
    # TODO: consider moving this into a scope in the snippet model
    q = "%#{params[:search]}%"
    @snippets = Snippet.joins(:category).
      where("snippets.title ILIKE ? OR
             snippets.block ILIKE ? OR
             categories.title ILIKE ? AND
             snippets.is_private = ?",
             q, q, q, false)
  end

end
