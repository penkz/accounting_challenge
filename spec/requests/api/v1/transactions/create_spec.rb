# frozen_string_literal: true

require 'rails_helper'

RSpec.describe('Create Transaction', type: :request) do
  let(:source_account) { FactoryBot.create(:account, balance: 1000.00) }
  let(:destination_account) { FactoryBot.create(:account, balance: 500.00) }

  describe 'post /transactions' do
    let(:valid_attributes) do
      {
        transaction: {
          source_account_id: source_account.to_param,
          destination_account_id: destination_account.to_param,
          amount: 19.90
        }
      }
    end

    context 'with valid attributes' do
      it 'returns 201 created' do
        post api_v1_transactions_path, params: valid_attributes
        expect(response).to(have_http_status(:created))
      end

      it 'process the transaction' do
        post api_v1_transactions_path, params: valid_attributes
        expect(destination_account.total_balance).to eq 519.90
        expect(source_account.total_balance).to eq 980.10
      end

      it 'process the transaction' do
        post api_v1_transactions_path, params: valid_attributes
        expect(json_response['message']).to match /The transfer was successfully processed/
      end
    end

    context 'when source_account_id is missing' do
      before { valid_attributes[:transaction][:source_account_id] = nil }

      it 'does not process the transaction' do
        post api_v1_transactions_path, params: valid_attributes
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end
  end
end
