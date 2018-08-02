class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :store
      t.string :title
      t.integer :size
      t.decimal :price_per_day
      t.decimal :price_per_week
      t.decimal :price_per_month

      t.timestamps null: false
    end
  end
end
