class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text          :comment

      t.belongs_to    :user, index: true
      t.belongs_to    :shop, index: true

      t.timestamps null: false
    end
  end
end
