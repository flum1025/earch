# Earch

This application monitors the Twitter timeline and notifies Slack according to the conditions.

## Installation

    $ gem install earch

### Docker

you can use docker repository [flum1025/earch](https://hub.docker.com/r/flum1025/earch)

    $ docker run -v $(pwd)/setting.yml:/setting.yml flum1025/earch

self build

    $ git clone https://github.com/flum1025/earch.git
    $ docker build -t earch .

compose

    $ git clone https://github.com/flum1025/earch.git
    $ vim setting.yml # make configuration file
    $ docker-compose up

## Usage

You must be prepared the configuration file first(The details will be described later). Save configuration file and run the following command.

    $ earch -s setting.yml

## Configuration File

Configuration file is `YAML` format file. YAML key and their allowable values are described below.

### Example

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
  - text: !ruby/regexp /test.*/
    screen_name: twitterdev
  - hashtag:
      - test
      - events
    favorite_count: 50
  - lang: ja
    retweet: false
    quote: false
    reply: true
```

### twitter

This key is for `Twitter` configuration.

Argument|Required|Description
---|---|---
stream_options|Optional|Refer to [Streaming API request parameters](https://dev.twitter.com/streaming/overview/request-parameters)
api_key|Required|Get from [Twitter Application Management](https://apps.twitter.com/)

### slack

This key is for `Slack` configuration.

Argument|Required|Description
---|---|---
api_key|Required|Get from [Bots](https://your-team.slack.com/apps/manage/custom-integrations)
user_icon|Optional|Set the [Slack emoji](https://flum1025.slack.com/customize/emoji)
notify_channel|Required|Specify the notification channel
icon|Optional|Set your Twitter account icon

### rules

The value corresponding to a key is need to `Array`. You can use multiple rules and conditions.

Argument|DataType|Example|Comments
---|---|---|---
text|String|`text: tweet text`
||Regexp|`text: !ruby/regexp /^\d+$/`
user_id|String|`user_id: "12345"`|Not a number
user_name|String|`user_name: twitter name`
||Regexp|`user_name: !ruby/regexp /^[A-Z]+$/`
screen_name|String|`screen_name: screen name`
||Regexp|`screen_name: !ruby/regexp /^@test[0-9]+/`
favorite_count|Integer|`favorite_count: 50`|Get over 50 the number of favorites
||Range|`favorite_count: !ruby/range 10..20`|The number of favorites is 10 to 20
retweet_count|Integer|`retweet_count: 50`
||Range|`retweet_count: !ruby/range 10..20`
lang|String|`lang: ja`
||Regexp|`lang: !ruby/regexp /(ja\|en)/`
user_lang|String|`user_lang: ja`
||Regexp|`user_lang: !ruby/regexp /(ja\|en)/`
source|Array\<String>|`source: [TweetDeck, Twitter for WEB]`
hashtag|Array\<String>|`source: [test, memo]`|
mention|Array\<String>|`source: [twitter, twitterdev]`|String for screen_name
||Array\<Integer>|`source: [123, 456]`|Integer for id
reply|Boolean|`reply: false`
quote|Boolean|`quote: false`
retweet|Boolean|`retweet: false`


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flum1025/earch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Earch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/flum1025/earch/blob/master/CODE_OF_CONDUCT.md).
