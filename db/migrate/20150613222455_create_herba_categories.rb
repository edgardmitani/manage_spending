class CreateHerbaCategories < ActiveRecord::Migration
  def change
    create_table :herba_categories do |t|
    	t.string :name

      t.timestamps null: false
    end
  end
end
