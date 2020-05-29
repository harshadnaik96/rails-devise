class NotesController < ApplicationController #   before_action :set_notes, only: %i[show edit update destroy] #
  before_action :authenticate_user!, except: %i[index show]

  def show
    @note = Note.find(params[:id])
  end

  def index
    @notes = Note.all
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note =
      current_user.notes.build(
        params.require(:note).permit(:title, :description)
      )
    if @note.save
      flash[:notice] = 'Note created successfully.'
      redirect_to @note
    else
      render 'new'
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(params.require(:note).permit(:title, :description))
      flash[:notiece] = 'Note updated successfully.'
      redirect_to @note
    else
      render 'edit'
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to notes_path
  end #render plain: params[:note]
end
