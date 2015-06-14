require 'spec_helper'
require 'uri'

describe Hooksler::Newrelic::BetaInput do
  subject { Hooksler::Newrelic::BetaInput.new({}) }

  let(:input) { subject }

  let(:request) do
    Hooksler::Test::Request.build(json_data, 'CONTENT_TYPE' => 'application/json')
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
    context 'general' do
      let(:fixture_address) { File.join('spec', 'fixtures') }

      let(:json_data) { File.read(File.join(fixture_address, 'beta.json')) }
      it_behaves_like 'correct input'

    end
  end

end