class AddDateToOrdersItems < ActiveRecord::Migration[5.1]
  def change
    add_column :orders_items, :date, :datetime
  end
end
