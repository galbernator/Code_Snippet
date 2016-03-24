FactoryGirl.define do
  factory :note_category do
    association :note, factory: :note
    association :category, factory: :category
  end
end
