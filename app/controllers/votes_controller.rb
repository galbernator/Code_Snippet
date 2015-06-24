class VotesController < ApplicationController

  def create
    snippet = Snippet.find params[:snippet_id]
    vote = current_user.votes.new(vote_params)
    vote.snippet = snippet
    if vote.save
      redirect_to snippet
    else
      redirect_to snippet
    end
  end

  def update
    snippet = Snippet.find params[:snippet_id]
    vote = current_user.votes.find params[:id]
    if vote.update(vote_params)
      redirect_to snippet
    else
      redirect_to snippet
    end
  end

  def destroy
    snippet = Snippet.find params[:snippet_id]
    vote = current_user.votes.find params[:id]
    vote.destroy
    redirect_to snippet
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

end
