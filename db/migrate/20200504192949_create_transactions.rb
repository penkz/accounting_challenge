# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :type
      t.decimal :amount, precision: 8, scale: 2
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
