class CreateHomeClients < ActiveRecord::Migration
  def change
    create_table :home_clients do |t|
    	t.string :name

      t.timestamps null: false
    end
  end
end
