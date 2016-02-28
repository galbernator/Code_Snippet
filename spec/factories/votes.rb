FactoryGirl.define do
  factory :vote do
    user      create(:user)
    snippet   create(:snippet)
  end

end
