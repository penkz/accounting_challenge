# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactions::Create, type: :service do
  let(:source_account) { FactoryBot.create(:account, balance: 2000.00) }
  let(:destination_account) { FactoryBot.create(:account, balance: 1500.00) }
  describe '.run' do
    before do
      source_account
      destination_account
    end

    let(:valid_params) do
      {
        source_account_id: source_account.to_param,
        destination_account_id: destination_account.to_param,
        amount: 250.54
      }
    end

    context 'when the source account has a sufficient balance' do
      it 'it runs successfully' do
        outcome = described_class.run(valid_params)
        expect(outcome).to be_success
      end

      it 'it withdraws the amount from the source account' do
        described_class.run(valid_params)
        expect(source_account.total_balance).to eq(1749.46)
      end

      it 'it deposits the amount in the destination account' do
        described_class.run(valid_params)
        expect(destination_account.total_balance).to eq(1750.54)
      end
    end

    context 'when the source account has an insuffient balance' do
      it 'it does not withdraw the amount from the source account' do
        described_class.run(valid_params, amount: 2000.01)
        expect(source_account.total_balance).to eq(2000.0)
      end

      it 'it does not deposit the amount in the destination account' do
        described_class.run(valid_params, amount: 2000.01)
        expect(destination_account.total_balance).to eq(1500.00)
      end

      it 'returns and error message' do
        outcome = described_class.run(valid_params, amount: 2000.01)
        expect(outcome.errors.message[:source_account_id]).to match /Account has insufficient funds./
      end
    end

    context 'when the source account is missing' do
      it 'does not execute the transfer' do
        outcome = described_class.run(valid_params, source_account_id: nil)
        expect(outcome).not_to be_success
      end
    end

    context 'when the destination account is missing' do
      it 'does not execute the transfer' do
        outcome = described_class.run(valid_params, destination_account_id: nil)
        expect(outcome).not_to be_success
      end
    end

    context 'when the amount is missing' do
      it 'does not execute the transfer' do
        outcome = described_class.run(valid_params, amount: nil)
        expect(outcome).not_to be_success
      end
    end
  end
end
