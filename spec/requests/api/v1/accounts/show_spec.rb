# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Show Account balance', type: :request) do
  describe 'get /accounts/:id' do
    let(:account) { FactoryBot.create(:account, balance: 1200.0) }
    let(:success_response) do
      {
        'id' => account.to_param,
        'balance' => account.total_balance.to_f
      }
    end

    let(:token) { JsonWebToken.encode({ id: account.id }) }
    let(:invalid_response) do
      { 'error' => instance_of(String) }
    end

    let(:headers) do
      { 'Authorization' => "Bearer #{token}" }
    end

    context 'when the account exists' do
      it 'returns 200 ok' do
        get api_v1_account_path(account.id), headers: headers
        expect(response).to have_http_status :ok
      end

      it 'returns the expected response' do
        get api_v1_account_path(account.id), headers: headers
        expect(json_response).to match success_response
      end
    end

    context 'when the account does not exist' do
      it 'returns 404 not found' do
        get api_v1_account_path(90), headers: headers
        expect(response).to have_http_status :not_found
      end

      it 'shows the error message' do
        get api_v1_account_path(90), headers: headers
        expect(json_response).to match invalid_response
      end
    end

    context 'with an invalid token' do
      let(:token) { JsonWebToken.encode({ id: 'unknown' }) }
      it 'returns 401 unauthorized' do
        get api_v1_account_path(account.id), headers: headers
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when theres no authentication header' do
      it 'returns 401 unauthorized' do
        get api_v1_account_path(account.id)
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
