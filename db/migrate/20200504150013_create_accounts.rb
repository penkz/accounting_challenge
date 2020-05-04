# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :balance, default: 0, precision: 8, scale: 2

      t.timestamps
    end
  end
end
