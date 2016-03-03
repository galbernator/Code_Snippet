FactoryGirl.define do
  factory :vote do
    association :user, factory: :user
    association :snippet, factory: :snippet
    is_up       true
  end

end
