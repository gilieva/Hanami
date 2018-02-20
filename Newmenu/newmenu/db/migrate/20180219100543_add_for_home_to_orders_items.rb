class AddForHomeToOrdersItems < ActiveRecord::Migration[5.1]
  def change
    add_column :orders_items, :for_home, :integer
  end
end
