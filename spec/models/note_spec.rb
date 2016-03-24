require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'validations' do
    def valid_attributes(new_attributes = {})
      {
        title:       'Some valid title',
        body:       'Some valid body',
      }.merge(new_attributes)
    end
    it 'requires a title' do
      note = Note.new(valid_attributes({ title: nil }))
      expect(note).to be_invalid
    end
    it 'requires a body' do
      note = Note.new(valid_attributes({ body: nil }))
      expect(note).to be_invalid
    end
  end
end
