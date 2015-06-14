require 'spec_helper'
require 'uri'

describe Hooksler::Newrelic::LegacyInput do
  subject { Hooksler::Newrelic::LegacyInput.new({}) }

  let(:input) { subject }

  let(:request) do
    Hooksler::Test::Request.build(nil, params: {alert: json_data})
  end

  it do
    should respond_to :load
  end

  context 'wrong request' do
    context 'empty data' do
      let(:json_data) { '' }
      it_behaves_like 'wrong input'
    end

    context 'wrong conent type' do
      let(:request) do
        Hooksler::Test::Request.build('')
      end

      it_behaves_like 'wrong input'
    end

  end

  context 'alert' do
    context 'web app' do
      let(:fixture_address) { File.join('spec', 'fixtures', 'web_app') }

      context 'generic' do
        context 'opened' do
          let(:json_data) { File.read(File.join(fixture_address, 'generic_opened.json')) }
          it_behaves_like 'correct input'
        end

        context 'closed' do
          let(:json_data) { File.read(File.join(fixture_address, 'generic_closed.json')) }
          it_behaves_like 'correct input'
        end
      end

    end


    context 'server' do
      let(:fixture_address) { File.join('spec', 'fixtures', 'server') }

      context 'generic' do
        context 'opened' do
          let(:json_data) { File.read(File.join(fixture_address, 'generic_opened.json')) }
          it_behaves_like 'correct input'
        end

        context 'closed' do
          let(:json_data) { File.read(File.join(fixture_address, 'generic_closed.json')) }
          it_behaves_like 'correct input'
        end
      end

    end
  end

end