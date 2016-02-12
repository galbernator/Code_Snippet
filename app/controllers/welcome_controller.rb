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
    @search = params[:seach]
    # TODO: consider moving this into a scope in the snippet model
    q = "%#{params[:search]}%"
    if current_user
      @snippets = Snippet.joins(:category).
        where("snippets.title ILIKE ? OR
               snippets.block ILIKE ? OR
               categories.title ILIKE ? AND
               (snippets.is_private = ? AND
               snippets.user_id = ?)",
               q, q, q, true, current_user.id).
               order("length(snippets.title)")
      else
        @snippets = Snippet.joins(:category).where(is_private: false).
          where("snippets.title ILIKE ? OR
                 snippets.block ILIKE ? OR
                 categories.title ILIKE ?",
                 q, q, q).order("length(snippets.title)")
      end

  end

end
