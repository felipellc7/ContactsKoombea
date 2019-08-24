class AddColumnsToEntities < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :contacts, :address, :string
    add_column :contacts, :social_networks, :string, array: true, default: []
  end
end
