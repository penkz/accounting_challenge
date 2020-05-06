# frozen_string_literal: true

module Transactions
  class Create < Mutations::Command
    required do
      integer :source_account_id
      integer :destination_account_id
      float :amount
    end

    def execute
      ActiveRecord::Base.transaction do
        source_account.withdraw(amount)
        destination_account.deposit(amount)
      end
    end

    def validate
      if amount > source_account.total_balance
        add_error(:source_account_id, :invalid, 'Account has insufficient funds.')
      end
    end

    private

    def source_account
      @source_account ||= Account.find(source_account_id)
    end

    def destination_account
      @destination_account ||= Account.find(destination_account_id)
    end
  end
end
