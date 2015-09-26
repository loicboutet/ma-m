class AddDetailsToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :quality, :integer
    add_column :ratings, :service, :integer
    add_column :ratings, :price, :integer
  end
end
