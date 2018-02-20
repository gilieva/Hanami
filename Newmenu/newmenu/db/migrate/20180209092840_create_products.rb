class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.text :name, null: false
      t.text :description
      t.decimal :price, precision: 15, scale: 3
      t.text :category, null: false

      t.timestamps
    end
  end
end
