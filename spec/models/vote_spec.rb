require 'rails_helper'

RSpec.describe Vote, type: :model do

  describe 'validations' do
    it 'does not allow user to vote twice on same snippet' do
      user = create(:user)
      snippet = create(:snippet)
      vote_1 = create(:vote, user_id: user.id, snippet_id: snippet.id)
      vote_2 = build(:vote, user_id: user.id, snippet_id: snippet.id)
      expect(vote_2).to be_invalid
    end
  end
end
