class WelcomeController < ApplicationController

  def index
    list = Category.all.pluck(:id)
    array_of_ids = []
    hash_of_language_and_count = Hash.new
    list.each { |id| array_of_ids << id }
    array_of_ids.each do |category_id|
      language_title = (Category.find category_id).title
      count = Snippet.where(category_id: category_id).length
      hash_of_language_and_count[language_title] = count
    end
    hash_of_language_and_count = hash_of_language_and_count.sort_by{|k, v| v}.reverse!
    @top_11 = []
    for i in 0...11
      @top_11 << hash_of_language_and_count[i]
    end
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
