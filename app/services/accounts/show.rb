# frozen_string_literal: true

module Accounts
  class Show < Mutations::Command
    required do
      string :id
    end

    def execute
      {
        id: id,
        balance: account.total_balance
      }
    end

    private

    def account
      @account ||= Account.find(id)
    end
  end
end
