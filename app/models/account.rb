# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  validates :id, uniqueness: true

  has_many :transactions

  def total_balance
    transactions.reduce(balance) do |sum, transaction|
      sum + (transaction.deposit? ? transaction.amount : -transaction.amount)
    end
  end

  def deposit(amount)
    transactions.deposit.create(amount: amount)
  end

  def withdraw(amount)
    transactions.withdraw.create(amount: amount)
  end
end
