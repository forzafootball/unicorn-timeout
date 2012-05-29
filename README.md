# Unicorn::Timeout

Middleware for timing out current unicorn worker if request takes to long time.

If a request times out, a handler block will be called and the current worker
process will be killed (using SIGTERM).

## Compatibility

The gem is tested using Ruby 1.9.3p194.

## Installation

Add this line to your application's Gemfile:

    gem 'unicorn-timeout'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unicorn-timeout

## Setup/Usage (Rails 3)

In `config/application.rb`:

    config.middleware.use Unicorn::Timeout

In `config/initializer/unicorn-timeout.rb` (optional):

    # Timeout in seconds
    Unicorn::Timeout.timeout = 15 # default

    # Block that will run (within Thread.exclusive, on monitor thread) just before sending signal to process
    Unicorn::Timeout.handler = lambda { |backtrace| STDERR.puts("Unicorn::Timeout is killing worker ##{Process.pid} with backtrace:\n#{backtrace.inspect}") } # default

    # Signal that will be sent to current process if timeout is reached
    Unicorn::Timeout.signal  = "TERM" # default

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credit

This work was inspired and influenced by [rack-timeout](https://github.com/kch/rack-timeout).
