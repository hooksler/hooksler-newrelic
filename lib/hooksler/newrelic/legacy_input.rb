require 'hooksler/newrelic/slack_formatter'

module Hooksler
  module Newrelic
    class LegacyInput
      extend Hooksler::Inbound
      register :newrelic

      def initialize(params)
        @params = params
      end

      def load(request)
        return unless request.content_type == 'application/x-www-form-urlencoded'
        action, payload = request.POST.first
        payload = MultiJson.load(payload)

        build_message(payload) do |msg|
          begin
            method_name = "for_#{action}"
            self.send method_name, msg, payload
          rescue
          end
        end
      end

      private

      def for_alert(msg, data)
        msg.message = data['long_description']
        msg.user    = data['account_name']
        msg.url     = data['alert_url']
        msg.title   = data['short_description']
        msg.level   = :critical
      end

      def for_deployment(msg, data)
        msg.message = data['description']
        msg.user    = data['deployed_by']
        msg.url     = data['deployment_url']
        msg.title   = data['application_name']
      end
    end
  end
end
