class AddActiveToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :active, :integer
  end
end
