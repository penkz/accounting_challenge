# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) do
    {
      'id' => 1,
      'name' => 'John Smith'
    }
  end

  let(:secret_key) { Rails.application.secrets.secret_key_base }

  describe '.encode' do
    before { allow(JWT).to receive(:encode).with(payload, secret_key) }

    it 'calls the JWT gem to encode the payload' do
      described_class.encode(payload)

      expect(JWT).to have_received(:encode).with(payload, secret_key)
    end
  end

  describe '.decode' do
    let(:token) { described_class.encode(payload) }
    before { allow(JWT).to receive(:decode).with(token, secret_key).and_call_original }

    it 'calls the JWT gem to decode the payload' do
      described_class.decode(token)

      expect(JWT).to have_received(:decode).with(token, secret_key)
    end

    it 'gets the account id from the payload' do
      expect(described_class.decode(token)).to match(payload)
    end
  end
end
