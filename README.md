# AC::Logger

Small wrapper around the default ruby Logger class to contain a couple of conventions and conveniences assembled over the years including:
 - exception logging together with their callstacks
 - easily parsable timestamps 
 - easily log level marker

To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ac-logger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ac-logger

## Usage

require 'ac/logger'

get a logger instance, for example at top of your class, and log away:

    class A
        Log = AC::Logger['/var/log/foo.log']
        
        def somefunc
            Log.debug "bla bla bla.."
        rescue => e
            Log.ex(e, "just a demo, relax")
        ensure
    end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ac-logger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

