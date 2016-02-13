class WelcomeController < ApplicationController

  def index
    language_and_count_hash = {}
    Category.all.each do |category|
      language_title = category.title
      count = category.snippets.count
      language_and_count_hash[language_title] = count
    end
    @top_11 = language_and_count_hash.sort_by{ |language, count| count }.reverse.first(11)
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
