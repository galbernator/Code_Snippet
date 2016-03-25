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

  def show
    @note = current_user.notes.find params[:id]
  end

  def edit
    @note = current_user.notes.find params[:id]
  end

  def update
    @note = current_user.notes.find params[:id]
    if @note.update(note_params)
      redirect_to @note
    else
      render :edit
    end
  end

  def destroy
    note = current_user.notes.find params[:id]
    note.destroy
    redirect_to notes_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :body, category_ids: [])
  end

end
