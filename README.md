[![Build Status](https://travis-ci.org/piotr-galas/use_case_flow.svg?branch=master)](https://travis-ci.org/piotr-galas/use_case_flow)
[![Gem Version](https://badge.fury.io/rb/use_case_flow.svg)](https://badge.fury.io/rb/use_case_flow)
# UseCaseFlow

This gem provide easy and readable way to invoke services/use_cases in your controller

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'use_case_flow', require: false
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install use_case_flow
    
## Intention
    
Controllers should take care only on things related to http, like `redirect`, `render` , `request`. `response` and so on. Writing code became much easier when we invoke our models inside service/use_cases
 instead in controllers. Imagine code where you invoke some service and then based on result you render special template, or redirect to url and nothing more. From practical point of view we always have one success path
 and few failures.  This gem allow very readable syntax for that case.
 


## Usage
   To create service you must:
   -  `require use_case_flow` 
   -  Method you invoke in controller MUST return instance of Success or Failure
   -  As example i use `return` `if`  syntax because it is easiest way to demonstrate how doest it work. You can use other technics but method must return `Success` or `Failure` instance 
 
   ```ruby
   
    `require use_case_flow` 
   
     class SomeService
       def call # you can use different name of method 
         return Failure.new(:name_what_was_wrong, 'data put to controller') if semething_go_wrong
         return Failure.new(:email_is_empty, {}) if empty_email? 
         return Failure.new(:user_not_found, User.new ) if user?
         Success.new('data put to controller')   
       end
     end
     
     class UserController
        
       def create
         result = SomeService.new.call
         # order of line below have no matter
         result.name_what_was_wrong { |data_from_service| render :template, json: data_from_service }
         result.email_is_empty { |data_from_service| redirect_to 'www.example.com' }
         result.user_not_found {|new_user| render json: new_user, status: 422}
         result.success{ |text| render plain: text}
       end
     end
   ```
   example usage from real project, it shows how your controller could looks
   - [controller](https://github.com/piotr-galas/use_case_flow/blob/master/example/auction_controller.rb)
   - [service](https://github.com/piotr-galas/use_case_flow/blob/master/example/archive.rb)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. Then, run `rubocop` to run the rubocop ,You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotr-galas/use_case_flow. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

