require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  def str
    "\tThis\sis\stest\sstring"
  end
  describe '#kramdown' do
    it 'returns a string of html' do
      expect(helper.kramdown(str)[0..10]).to eq('<pre><code>')
    end
    it 'replaces any tabs with double spaces' do
      expect(kramdown(str).include?("\t")).to be false
    end
  end

end
