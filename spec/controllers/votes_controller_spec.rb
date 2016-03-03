require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  let(:vote) { create(:vote) }
  let(:snippet) { create(:snippet) }
  let(:user) { create(:user) }

  describe 'Vote' do
    it 'is a valid vote' do
      expect(build(:vote)).to be_valid
    end
  end

  describe 'POST #create' do
    it 'creates a new vote in the database' do
      expect { post :create, snippet_id: snippet.id, vote: { is_up: true }, format: 'js' }.to change { Vote.count }.by(1)
    end
  end

  describe 'PATCH #update' do
    it 'changes the value of is_up' do
      @snippet = create(:snippet, title: 'JavaScript')
      @vote = create(:vote, is_up: true)
      patch :update, snippet_id: @snippet.id, id: @vote.id, vote: { is_up: false }
      expect(@vote.reload.is_up).to eq(false)
    end
  end

  describe 'DELETE #destroy' do
    it 'removes the vote from the database' do
      @snippet = create(:snippet, title: 'Go')
      @vote = create(:vote, snippet_id: @snippet.id)
      expect { delete :destroy, snippet_id: @snippet.id, id: @vote.id }.to change { Vote.count }.by(-1)
    end
  end

end
