class VotesController < ApplicationController

  def create
    @snippet = Snippet.find params[:snippet_id]
    @vote = (current_user ? current_user.votes.new(vote_params) : Vote.new(vote_params))
    @vote.snippet = @snippet
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @snippet }
        format.js { render }
      else
        format.html { redirect_to @snippet }
        format.js { render }
      end
    end
  end

  def update
    @snippet = Snippet.find params[:snippet_id]
    @vote = (current_user ? current_user.votes.find(params[:id]) : Vote.find(params[:id]))
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @snippet }
        format.js { render :update }
      else
        format.html { redirect_to @snippet }
        format.js { render :update }
      end
    end
  end

  def destroy
    @snippet = Snippet.find params[:snippet_id]
    @vote = current_user ? current_user.votes.find(params[:id]) : Vote.find(params[:id])
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to @snippet }
      format.js { render :destroy }
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

end
