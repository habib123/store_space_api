class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :title
      t.string :city
      t.string :street
      t.integer :spaces_count

      t.timestamps null: false
    end
  end
end
