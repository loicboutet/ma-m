class AddColumnsToShop < ActiveRecord::Migration
  def change
    add_column :shops, :email, :string
    add_column :shops, :site, :string
    add_column :shops, :facebook, :string
    add_column :shops, :twitter, :string
  end
end
