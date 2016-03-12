class NotesController < ApplicationController
  before_action: authorize

  def index
    @notes = current_user.notes
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      respond_to do |format|
        format.js
      end
  end

  private

  def note_params
    params.require(:note).permit(:title, :body, category_ids: [])
  end

end
