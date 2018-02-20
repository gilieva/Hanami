class CreateOrdersItems < ActiveRecord::Migration[5.1]
  def change
    create_table :orders_items do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.integer :quantity,null: false
      t.text :description

      t.timestamps
    end
  end
end
