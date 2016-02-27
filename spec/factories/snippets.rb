FactoryGirl.define do
  factory :snippet do
    title         'Awesomeness'
    block         "def something_awesome\n\tputs\s'This is cool.'\nend"
    description   'Does something awesome.'
  end

end
