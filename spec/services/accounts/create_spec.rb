# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::Create, type: :service do
  describe '.run' do
    let(:valid_params) do
      {
        name: 'New Account',
        balance: 9000.10
      }
    end

    let(:invalid_params) do
      {
        name: '',
        balance: 9000.10
      }
    end

    context 'when all params are valid' do
      it 'creates a new account' do
        expect { described_class.run(valid_params) }.to change { Account.count }.by(1)
      end

      it 'it runs successfully' do
        outcome = described_class.run(valid_params)
        expect(outcome).to be_success
      end

      it 'it returns the created account' do
        outcome = described_class.run(valid_params)
        expect(outcome.result).to be_an Account
      end

      it 'saves the correct data' do
        outcome = described_class.run(valid_params)
        result = outcome.result
        expect(result.name).to eq 'New Account'
        expect(result.balance).to eq 9000.10
      end
    end

    context 'when params is invalid' do
      it 'does not save the account' do
        expect { described_class.run(invalid_params) }.to change { Account.count }.by(0)
      end
    end

    context 'when the name is missing' do
      it 'returns the error message' do
        outcome = described_class.run(invalid_params)
        expect(outcome.errors.message[:name]).to match(/Name can't be blank/)
      end
    end

    context 'when the name id is already taken' do
      it 'returns the error message' do
        account = FactoryBot.create(:account)
        valid_params[:id] = account.to_param
        outcome = described_class.run(valid_params)
        expect(outcome.errors.message[:id]).to match(/An account with ID: \d+ already exists/)
      end
    end
  end
end
