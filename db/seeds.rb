# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  ["HTML", "Javascript", "Ruby", "CSS", "Angular.js", "Node.js", "React.js", "Bash", "C", "C++", "C#", "CoffeeScript", "Dart", "Ember.js", "Bootstrap", "Go", "Sass", "Java", "jQuery", "AJAX", "SQL", "Objective-C", "PHP", "Python", "Ruby on Rails", "Swift", ".NET", "Other"].each do |category|
    Category.create(title: category)
  end
