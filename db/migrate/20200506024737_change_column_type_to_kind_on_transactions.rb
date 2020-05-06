class ChangeColumnTypeToKindOnTransactions < ActiveRecord::Migration[6.0]
  def change
    rename_column :transactions, :type, :kind
  end
end
