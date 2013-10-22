# Sogou

Sogou SEM Services

## Installation

Add this line to your application's Gemfile:

    gem 'sogou'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sogou

## Knowledge
camel命名法，用于request数据格式
snake命名法，用于response数据格式

## Rspec
先修改spec/spec_helper.rb

```ruby

$username = ''
$password = ''
$token = ''

```

## Usage

SEM

```ruby
require 'sogou'

auth = Sogou::Auth.new
auth.username = 'username'
auth.password = 'password'
auth.token = 'token'

ss = Sogou::SEM::SearchService.new(auth)
res = ss.getAccountInfo({})
res = ss.getAccountInfo({},true) #debug=true
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request