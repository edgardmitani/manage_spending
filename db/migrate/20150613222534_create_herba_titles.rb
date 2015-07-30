class CreateHerbaTitles < ActiveRecord::Migration
  def change
    create_table :herba_titles do |t|
    	t.string :name
    	t.float :discount

      t.timestamps null: false
    end
  end
end
