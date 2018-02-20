class AddTotalPriceToOrdersItems < ActiveRecord::Migration[5.1]
  def change
    add_column :orders_items, :total_price, :decimal, scale: 3
  end
end
