# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :id }
  end

  describe 'associations' do
    it { should have_many :transactions }
  end

  describe '#total_balance' do
    let(:account) { FactoryBot.create(:account, balance: 1000.0) }

    it 'returns the total balance for the account' do
      account.deposit(100.00)
      account.withdraw(200.50)
      expect(account.total_balance).to eq 899.50
    end
  end

  describe '#deposit' do
    let(:account) { FactoryBot.create(:account, balance: 1000.0) }

    before { account.deposit(250.0) }
    it 'creates a new deposit transaction for the account' do
      expect(account.transactions.deposit.last.amount).to eq 250.0
      expect(account.transactions.last).to be_deposit
    end
  end

  describe '#withdraw' do
    let(:account) { FactoryBot.create(:account, balance: 1000.0) }

    before { account.withdraw(250.0) }
    it 'creates a new withdraw transaction for the account' do
      expect(account.transactions.withdraw.last.amount).to eq 250.0
      expect(account.transactions.last).to be_withdraw
    end
  end
end
