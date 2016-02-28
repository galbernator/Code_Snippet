FactoryGirl.define do
  factory :snippet_category do
    snippet    create(:snippet)
    category   create(:category)
  end

end
