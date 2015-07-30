class CreateHerbaClients < ActiveRecord::Migration
  def change
    create_table :herba_clients do |t|
    	t.references :herba_title, index: true
    	t.string :name
    	t.string :email, limit: 100
    	t.string :phone, limit: 20

      t.timestamps null: false
    end
  end
end
