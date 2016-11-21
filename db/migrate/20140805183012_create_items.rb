class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :inventory
      t.float :price
      t.integer :category_id

      t.timestamps
    end
  end
end
