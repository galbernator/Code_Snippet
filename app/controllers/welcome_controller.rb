class WelcomeController < ApplicationController

  def index
    @top_11 = Category.all.sort_by {|category| category.snippets.count }.reverse.first(11)
  end

  def search
    query = "%#{params[:search]}%"
    if current_user
      @snippets = ((Snippet.not_private.search_for(query)) + (current_user.snippets.search_for(query))).uniq
      else
        @snippets = Snippet.not_private.search_for(query)
      end
  end

end
