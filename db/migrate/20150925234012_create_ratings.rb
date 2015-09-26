class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.boolean   :like
      t.integer   :stars

      t.belongs_to  :shop, index: true
      t.belongs_to  :user, index: true

      t.timestamps null: false
    end
  end
end
