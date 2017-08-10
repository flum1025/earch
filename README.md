# Earch

This application monitors the Twitter timeline and notifies Slack according to the conditions.

## Installation

    $ gem install earch

## Usage

You must be prepared the configuration file first(The details will be described later). Save configuration file and run the following command.

    $ earch -s setting.yml

### Configuration File

Configuration file is `YAML` format file. YAML key and their allowable values are described below.

#### Example

```yaml
twitter:
  stream_options:
    replies: all
  screen_name: flum_        #require
  api_key:
    consumer_key:           #require
    consumer_secret:        #require
    access_token:           #require
    access_token_secret:    #require
slack:
  api_key:
    token:                  #require
    websocket_ping: 5
  user_icon: ':earch:'
  notify_channel: '#earch'  #require
  icon: ':flum_:'
rules:                      #require
  - text: !ruby/regexp /.+/
```

#### twitter

This key is for `Twitter` configuration.

##### stream_options

Refer to [Streaming API request parameters](https://dev.twitter.com/streaming/overview/request-parameters)
##### api_key

Get from [Twitter Application Management](https://apps.twitter.com/)

#### slack

This key is for `Slack` configuration.

##### api_key

Get from [Bots](https://your-team.slack.com/apps/manage/custom-integrations)

##### user_icon

Set the [Slack emoji](ht  tps://flum1025.slack.com/customize/emoji)

##### notify_channel

Specify the notification channel

##### icon

Set your Twitter account icon

#### rules

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/earch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Earch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/earch/blob/master/CODE_OF_CONDUCT.md).
