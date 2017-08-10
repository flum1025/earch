require "earch/version"
require "earch/rule"
require "twitter"
require "twitter-stream-patch"
require "hashie"
require "slack-ruby-client"
require "optparse"

class Earch
  def initialize(file)
    @setting = Hashie::Mash.load(file)
    @rules = Rules.new(@setting.rules)
    @stream_client = Twitter::Streaming::Client.new @setting.twitter.api_key
    @slack_client = Slack::Web::Client.new(@setting.slack.api_key)
  end

  def start #TODO: 例外処理
    @stream_client.user(@setting.twitter.stream_options) do |object|
      case object
      when Twitter::Tweet
        execute(object)
      end
    end
  rescue Interrupt
  end

  def debug(json)
    Slack::Web::Client.class_eval do
      define_method :chat_postMessage{|*args|p args}
    end
    execute(Twitter::Tweet.new(JSON.parse(json, {:symbolize_names => true})))
  end

  private
  def execute(object)
    if @rules.match?(object)
      notify(object)
    end
  end

  def notify(object)
    @slack_client.chat_postMessage(
      icon_emoji: @setting.slack.user_icon,
      username: 'Earch',
      channel: @setting.slack.notify_channel,
      attachments: notify_content(object)
    )
  end

  def notify_content(object)
    [
      {
        "fallback": "#{object.text} by @#{object.user.screen_name}",
        "color": "#4169e1",
        "author_name": "#{object.user.name}(@#{object.user.screen_name})",
        "author_link": object.user.url,
        "author_icon": object.user.profile_image_url_https,
        "text": object.text,
        "fields": [
          {
            "value": "<#{object.url}|Tweet>",
          }
        ],
        "footer": "#{@setting.slack.icon} #{@setting.twitter.screen_name}",
        "ts": object.created_at.to_f
      }
    ]
  end
end
