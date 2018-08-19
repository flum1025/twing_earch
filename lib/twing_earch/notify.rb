require 'slack-ruby-client'

class Earch::Notify
  attr_reader :client, :setting

  def initialize(setting)
    @setting = setting
    @client = Slack::Web::Client.new(setting.api_key)
  end

  def notify(object)
    client.chat_postMessage(
      icon_emoji: setting.user_icon,
      username: 'Earch',
      channel: setting.notify_channel,
      attachments: body(object)
    )
  end

  def body(object)
    [
      {
        fallback: "#{object.text} by @#{object.user.screen_name}",
        color: '#4169e1',
        author_name: "#{object.user.name}(@#{object.user.screen_name})",
        author_link: object.user.url,
        author_icon: object.user.profile_image_url_https,
        text: object.text,
        fields: [
          {
            value: "<#{object.url}|Tweet>",
          }
        ],
        footer: "#{setting.icon} #{setting.source_user}",
        ts: object.created_at.to_f
      }
    ]
  end
end
