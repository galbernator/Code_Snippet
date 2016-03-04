require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "validations" do
    def valid_attributes(new_attributes = {})
      {title: "Some valid title"}.merge(new_attributes)
    end
    it 'requires a title' do
      category = Category.new(valid_attributes({title: nil}))
      expect(category).to be_invalid
    end
    it 'rejects categories with duplicate titles' do
      category_1 = Category.create(valid_attributes({ title: 'Awesome Title'}))
      category_2 = Category.new(valid_attributes({ title: 'Awesome Title'}))
      expect(category_2).to be_invalid
    end
  end
end
