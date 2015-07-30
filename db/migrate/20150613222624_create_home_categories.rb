class CreateHomeCategories < ActiveRecord::Migration
  def change
    create_table :home_categories do |t|
    	t.string :name

      t.timestamps null: false
    end
  end
end
