require 'hooksler/newrelic/slack_formatter'
require 'hooksler'

module Hooksler
  module Newrelic
    class BetaInput
      extend Hooksler::Channel::Input
      register :newrelic_beta

      def initialize(params)
        @params = params
      end

      def load(request)
        return unless request.content_type == 'application/json'

        payload = MultiJson.load(request.body.read)

        Hooksler::Message.new(:newrelic_beta, payload) do |msg|
          msg.message = payload['details']
          msg.user = payload['condition_name']
          msg.url = payload['incident_url']
          msg.title = payload['policy_name']

          case payload['severity']
            when 'WARN'
              msg.level = :warning
            when 'INFO'
              msg.level = :info
            when 'CRITICAL'
              msg.level = :critical
          end

        end
      rescue MultiJson::ParseError
        nil
      end
    end
  end
end
