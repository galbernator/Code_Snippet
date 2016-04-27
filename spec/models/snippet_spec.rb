require 'rails_helper'

RSpec.describe Snippet, type: :model do

  describe 'validations' do
    def valid_attributes(new_attributes = {})
      {
        title:       'Some valid title',
        block:       'Some valid block',
        description: 'Some valid description',
      }.merge(new_attributes)
    end
    it 'does not allow duplicate titles' do
      snippet_1 = Snippet.create(valid_attributes({ title: 'Snippet of the Century' }))
      snippet_2 = Snippet.new(valid_attributes({ title: 'Snippet of the Century' }))
      expect(snippet_2).to be_invalid
    end
    it 'requires a block' do
      snippet = Snippet.new(valid_attributes({ block: nil }))
      expect(snippet).to be_invalid
    end
  end

  describe 'callbacks' do
    def valid_attributes(new_attributes = {})
      {
        title:       'Some valid title',
        block:       'Some valid block',
        description: 'Some valid description',
      }.merge(new_attributes)
    end
    context 'set_defaults' do
      it 'sets is_private to false when nil' do
        snippet = Snippet.new(valid_attributes({ is_private: nil }))
        expect(snippet.is_private).to eq(false)
      end
      it 'sets is_private to true when true' do
        snippet = Snippet.new(valid_attributes({ is_private: true }))
        expect(snippet.is_private).to eq(true)
      end
    end

    context 'format_block' do
      it 'does not format the block on building' do
        snippet = Snippet.new(valid_attributes({ block: "def block\r\n\s\sdo something\r\nend" }))
        expect(snippet.block).to eq("def block\r\n\s\sdo something\r\nend")
      end
      it 'formats the block before saving' do
        snippet = Snippet.new(valid_attributes({ block: "def block\r\n\s\sdo something\r\nend" }))
        snippet.save
        expect(snippet.block).to eq("~~~\ndef block\r\n\s\sdo something\r\nend\n~~~")
      end
    end
  end

  describe 'vote_for' do
    it 'finds a vote for a user when user has voted' do
      user = create(:user)
      snippet = create(:snippet)
      vote = create(:vote, snippet_id: snippet.id, user_id: user.id)
      expect(snippet.vote_for(user)).to eq(vote)
    end
    it 'finds no vote for a user when user has not voted' do
      user = create(:user)
      snippet = create(:snippet)
      vote = create(:vote, snippet_id: snippet.id)
      expect(snippet.vote_for(user)).to eq(nil)
    end
  end

  describe 'vote_result' do
    it 'returns the correct tally of votes' do
      snippet = create(:snippet)
      vote_1 = create(:vote, is_up: true, snippet_id: snippet.id)
      vote_2 = create(:vote, is_up: true, snippet_id: snippet.id)
      vote_3 = create(:vote, is_up: false, snippet_id: snippet.id)
      expect(snippet.vote_result).to eq(1)
    end
  end

  describe 'author' do
    it 'retunrs true if user created the snippet' do
      user = create(:user)
      snippet = create(:snippet, user_id: user.id)
      expect(snippet.author(user)).to eq(true)
    end
    it 'retunrs false if user created the snippet' do
      user = create(:user)
      snippet = create(:snippet)
      expect(snippet.author(user)).to eq(false)
    end
  end
end
