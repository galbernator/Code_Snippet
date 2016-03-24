class NotesController < ApplicationController
  before_action :authorize

  def index
    @notes = current_user.notes
    @categories = @notes.map { |note| note.categories }.flatten.uniq
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      respond_to do |format|
        format.html
        format.js { render }
      end
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :body, category_ids: [])
  end

end
