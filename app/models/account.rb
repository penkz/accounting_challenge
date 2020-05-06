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
    raise ActiveRecord::Rollback if amount.negative?

    transactions.deposit.create(amount: amount)
  end

  def withdraw(amount)
    raise ActiveRecord::Rollback if amount.negative? || amount > total_balance

    transactions.withdraw.create(amount: amount)
  end
end
