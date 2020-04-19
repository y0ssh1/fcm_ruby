# FcmRuby

FcmRuby gems lets your ruby backend send notification to android and ios via Firebase Cloud Messaging.
It's enable to [send to specific devices](https://firebase.google.com/docs/cloud-messaging/send-message?hl=ja#send_messages_to_specific_devices).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fcm_ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fcm_ruby

## Usage

```ruby
# api_keys can get by google-auth (https://github.com/googleapis/google-auth-library-ruby)
# See https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages for message structure
# message argument also supports array (send to multiple devices)
fcm = FcmPush.new("your_api_key", "firebase_project_id")
response = fcm.send(message)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

