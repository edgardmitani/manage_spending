class CreateHerbaProducts < ActiveRecord::Migration
  def change
    create_table :herba_products do |t|
    	t.references :herba_category, index: true
    	t.string :code, limit: 10
    	t.string :name
    	t.decimal :price, precision: 10, scale: 2
    	t.integer :portion

      t.timestamps null: false
    end
  end
end
