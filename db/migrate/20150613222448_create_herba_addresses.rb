class CreateHerbaAddresses < ActiveRecord::Migration
  def change
    create_table :herba_addresses do |t|
    	t.references :herba_client, index: true
      t.string :zip_code, limit: 10
    	t.string :street
    	t.string :number, limit: 10
    	t.string :neighborhood
    	t.string :city, limit: 100
    	t.string :state, limit: 50

      t.timestamps null: false
    end
  end
end
