# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Create Account', type: :request) do
  describe 'post /accounts' do
    let(:valid_attributes) do
      {
        account: {
          name: 'New Account',
          balance: 21_000.90
        }
      }
    end

    let(:invalid_attributes) do
      {
        account: {
          name: '',
          balance: 12.50
        }
      }
    end

    let(:success_response) do
      account = Account.last
      {
        'id' => account.to_param,
        'auth_token' => JsonWebToken.encode({ id: account.to_param, name: account.name })
      }
    end

    let(:invalid_response) do
      { 'errors' => instance_of(Hash) }
    end

    context 'with valid attributes' do
      it 'returns 201 created' do
        post api_v1_accounts_path, params: valid_attributes
        expect(response).to(have_http_status(:created))
      end

      it 'creates a new account' do
        expect { post api_v1_accounts_path, params: valid_attributes }.to(
          change { Account.count }.by(1)
        )
      end

      it 'returns the correct response format' do
        post api_v1_accounts_path, params: valid_attributes
        expect(json_response).to(match(success_response))
      end
    end

    context 'with invalid attributes' do
      it 'returns 422 unprocessable entity' do
        post api_v1_accounts_path, params: invalid_attributes
        expect(response).to(have_http_status(:unprocessable_entity))
      end

      it 'returns the errors hash' do
        post api_v1_accounts_path, params: invalid_attributes
        expect(json_response).to(match(invalid_response))
      end
    end

    context 'when an id is passed on the params' do
      let(:existing_account) { FactoryBot.create(:account) }
      before do
        valid_attributes[:account][:id] = 5
      end

      it 'returns 201 created' do
        post api_v1_accounts_path, params: valid_attributes
        expect(response).to(have_http_status(:created))
      end

      it 'creates a new account' do
        expect { post api_v1_accounts_path, params: valid_attributes }.to(
          change { Account.count }.by(1)
        )
      end
    end

    context 'when an account with a passed id already exists' do
      let(:existing_account) { FactoryBot.create(:account) }
      before do
        existing_account
        valid_attributes[:account][:id] = existing_account.to_param
      end

      it 'returns 422 unprocessable entity' do
        post api_v1_accounts_path, params: valid_attributes
        expect(response).to(have_http_status(:unprocessable_entity))
      end

      it 'returns the errors hash' do
        post api_v1_accounts_path, params: valid_attributes
        expect(json_response).to(match(invalid_response))
      end
    end
  end
end
