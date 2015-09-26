class AddRegularToComment < ActiveRecord::Migration
  def change
    add_column :comments, :regular, :boolean
    add_column :comments, :date, :datetime
  end
end
