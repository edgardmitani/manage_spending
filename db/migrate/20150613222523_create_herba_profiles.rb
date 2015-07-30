class CreateHerbaProfiles < ActiveRecord::Migration
  def change
    create_table :herba_profiles do |t|
    	t.references :herba_client, index: true
    	t.float :weight
    	t.float :chest
    	t.float :rib
    	t.float :belly
    	t.float :hip

      t.timestamps null: false
    end
  end
end
