# frozen_string_literal: true

module Accounts
  class Create < Mutations::Command
    required do
      string :name
    end

    optional do
      integer :id
      float :balance
    end

    def execute
      account = Account.new(inputs)
      account.save && account
    end

    def validate
      add_error(:id, :invalid, "An account with ID: #{id} already exists") if id && Account.find_by(id: id)
    end
  end
end
