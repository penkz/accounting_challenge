# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::Show, type: :service do
  let(:account) { FactoryBot.create(:account, name: 'A new account', balance: 1000.0) }

  describe '.run' do
    context 'when the account exists' do
      let(:expected_result) do
        {
          id: account.to_param,
          balance: account.total_balance
        }
      end

      it 'returns the expected result' do
        expect(described_class.run!(id: account.id)).to match(expected_result)
      end
    end

    context 'when the account does not exist' do
      it 'returns the expected result' do
        expect { described_class.run!(id: 42) }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the account id is missing' do
      it 'returns the expected result' do
        expect { described_class.run!(id: nil) }.to(
          raise_error(Mutations::ValidationException, /ID can't be nil/)
        )
      end
    end
  end
end
