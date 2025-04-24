class AddPriceToTransaction < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :current_price, :decimal, precision: 10, scale: 2
    add_column :transactions, :total, :decimal, precision: 10, scale: 2
  end
end
