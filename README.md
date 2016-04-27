#CODE SNIPPET

[![Code Climate](https://codeclimate.com/github/galbernator/Code_Snippet/badges/gpa.svg)](https://codeclimate.com/github/galbernator/Code_Snippet)
[![Test Coverage](https://codeclimate.com/github/galbernator/Code_Snippet/badges/coverage.svg)](https://codeclimate.com/github/galbernator/Code_Snippet/coverage)

A place to store your favorite code snippets, search for helpful snippets posted by the community, and store notes to help you revisit those "ah ha!" moments.

##Getting Started
To get the app up and running, just follow these 3 special steps:

####Step 1 - Clone the repo locally
```
git clone https://github.com/galbernator/Code_Snippet.git code_snippet_app
```

####Step 2 - Enter the directory and bundle
```
cd code_snippet_app
bundle
```

####Step 3 - Set up the database and start the server
* Seeds will be coming shortly...so until then, leave off the "db:seed"

```
bin/rake db:create db:migrate db:seed
bin/rails s
```

##Running Tests
Running the tests is as simple as throwing a little `rspec` in the console! You're welcome!
