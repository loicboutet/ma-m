class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string    :title
      t.string    :phone
      t.string    :address
      t.string    :job

      t.timestamps null: false
    end
  end
end
