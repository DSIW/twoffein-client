# Twoffein-Client
Client-Version: 0.0.1 | API-Version:    0.2

This client for [Twoffein](http://twoffein.com/)'s [API](http://twoffein.com/api-faq/).

## Installation

_This gem isn't deployed on rubygems.org yet. Please clone this repository and run `rake install`._

Add this line to your application's Gemfile:

    gem 'twoffein-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twoffein-client

## Usage

```
NAME
    twoffein-client - Client for API 0.2 twoffein.de

SYNOPSIS
    twoffein-client [global options] command [command options] [arguments...]

VERSION
    0.0.1

GLOBAL OPTIONS
    --help    - Show this message
    --version - Show version

COMMANDS
    cookie  - Give cookie to RECEIVER
    drinks  - List all drinks
    help    - Shows a list of commands or help for one command
    profile - List the profile, which you have chosen by PROFILE
    tweet   - Tweet your drinking DRINK

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
