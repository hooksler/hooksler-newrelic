require 'hooksler/newrelic/slack_formatter'

module Hooksler
  module Newrelic
    class BetaInput
      extend Hooksler::Inbound
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
          msg.level = payload['severity'].downcase.to_sym
        end
      end
    end
  end
end
