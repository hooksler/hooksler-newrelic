module Hooksler
  module Newrelic
    module SlackFormatter
      def for_newrelic_legacy(message)

        text = message.raw['long_description']
        text = "[#{message.raw['servers'].join(', ')}] #{text}" if message.raw['servers']

        color =
            case message.raw['long_description']
              when /ended/
                '#00D000'
              when /opened/
                '#D00000'
            end

        {
            text: text,
            channel: self.channel,
            user: self.username,
            attachments: [
                {
                    fallback: text,
                    pretext: text,
                    color: color,
                    fields: [
                        {
                            title: 'Message',
                            value: "<#{message.raw['alert_url']}|#{message.raw['message']}>",
                            short: false
                        },
                        {
                            title: 'Start time',
                            value: Time.parse(message.raw['created_at']).to_s,
                            short: true
                        },
                        {
                            title: 'Severity',
                            value: message.raw['severity'],
                            short: true
                        }
                    ]
                }
            ]
        }
      end

      def for_newrelic_beta(message)

      end
    end
  end
end

if autoload?(:'Hooksler::Slack::Output') || defined?(Hooksler::Slack::Output)
  Hooksler::Slack::Output.send :include, Hooksler::Newrelic::SlackFormatter
end