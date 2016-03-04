require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    def valid_attributes(new_attributes = {})
      {
        first_name:  'Some valid first name',
        last_name:   'Some valid last name',
        email:       'valid@email.com',
        password:    'supersecurepw'
      }.merge(new_attributes)
    end
    it 'requires first_name' do
      user = User.new(valid_attributes({ first_name: nil }))
      expect(user).to be_invalid
    end
    it 'requires last_name' do
      user = User.new(valid_attributes({ last_name: nil }))
      expect(user).to be_invalid
    end
    it 'requires an email' do
      user = User.new(valid_attributes({ email: nil }))
    end
    it 'is valid when email is in a valid format' do
      user = User.new(valid_attributes({ email: 'test@email.com' }))
      expect(user).to be_valid
    end
    it 'is invalid when email is not in a valid format' do
      user = User.new(valid_attributes({ email: 'test@email' }))
      expect(user).to be_invalid
    end
  end

  describe 'is_admin' do
    it 'returns true when user is admin' do
      user = create(:user, role: 'admin')
      expect(user.admin?).to eq(true)
    end
    it 'returns false when user is admin' do
      user = create(:user, role: nil)
      expect(user.admin?).to eq(false)
    end
  end
end
