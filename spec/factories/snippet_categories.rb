FactoryGirl.define do
  factory :snippet_category do
    association :snippet, factory: :snippet
    association :category, factory: :category
  end

end
