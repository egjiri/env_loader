# EnvLoader [![Build Status](https://travis-ci.org/egjiri/env_loader.svg)](https://travis-ci.org/egjiri/env_loader)

By: Endri Gjiri *www.name-reaction.com*

**EnvLoader** is a utility module with methods to load a .yml file and store its data in environment variables. This is useful when dealing with sensitive data that should not be directly entered in the code and stored in version control. Passwords and other information can now simply be stored in a yaml file which should be added to .gitignore and then can be accessed through the env_loader gem via ENV variables

## Installation

Add this line to your application's Gemfile:

    gem 'env_loader'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install env_loader

## Usage
##### TODO: Better Document this section
* `> EnvLoader.setup_monolith`
* `> EnvLoader.setup_microservice`
* `$ rake env_loader:set_heroku_configs[heroku_app,config_file,config_subtree_key]`

---

## DEPRECATED Usage

1. Include the env_loader gem directly or through bundler
```ruby
require 'env_loader'
```

2. Create a .yml file with all the desired information. For example:
```yml
default: &default
     username: 'endri'
development:
     <<: *default
     password: 'password'
production:
     <<: *default
     password: 'secret'
```

3. Read the .yml file through the env_loader gem as follows:
```ruby
EnvLoader.read('credentials.yml')
```

The data is now available through Ruby's ENV accessor. Always user uppercase strings as the key even though they were lowercase in the .yml file, for example:
```ruby
ENV['USERNAME'] # => "endri"
ENV['PASSWORD'] # => "secret"
```

## DEPRECATED Usage with Rails

1. Add the env_loader gem to the Gemfile and run `Bundle install`

2. Create a file called *env_variables.yml* in the *config* directory with the desired data. This is the default path where the gem will look in and does not require passing in the path to the `read` method

3. Read the .yml file through the env_loader gem by adding the following line to *config/application.rb*
```ruby
EnvLoader.read
```

The data can now be accessed throughout the Rails app using `ENV['KEY']` as explaied above.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
