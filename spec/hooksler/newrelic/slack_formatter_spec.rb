require 'spec_helper'
require 'uri'

class FormatterTest
  include  Hooksler::Newrelic::SlackFormatter

  def channel
    '#test'
  end

  def username
    'test'
  end
end

describe Hooksler::Newrelic::SlackFormatter do
  subject { FormatterTest.new }
  let(:input){ Hooksler::Newrelic::LegacyInput.new({}) }

  let(:request) do
    Hooksler::Test::Request.build(nil, params: {alert: json_data})
  end

  let(:message) { input.load request }

  shared_examples 'slack formatter' do
    it do
      expect { subject.send("for_#{input.class.channel_name}", message) }.to_not raise_error
    end
  end

  it do
    should respond_to "for_#{input.class.channel_name}"
  end

  context 'alert' do
    context 'web app' do
      let(:fixture_address) { File.join('spec', 'fixtures', 'web_app') }

      context 'generic' do
        context 'opened' do
          let(:json_data) { File.read(File.join(fixture_address, 'generic_opened.json')) }
          it_behaves_like 'correct input'
          it_behaves_like 'slack formatter'
        end

        context 'closed' do
          let(:json_data) { File.read(File.join(fixture_address, 'generic_closed.json')) }
          it_behaves_like 'correct input'
          it_behaves_like 'slack formatter'
        end
      end

    end


    context 'server' do
      let(:fixture_address) { File.join('spec', 'fixtures', 'server') }

      context 'generic' do
        context 'opened' do
          let(:json_data) { File.read(File.join(fixture_address, 'generic_opened.json')) }
          it_behaves_like 'correct input'
          it_behaves_like 'slack formatter'
        end

        context 'closed' do
          let(:json_data) { File.read(File.join(fixture_address, 'generic_closed.json')) }
          it_behaves_like 'correct input'
          it_behaves_like 'slack formatter'
        end
      end

    end
  end

end