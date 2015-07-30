class CreateHerbaTransactions < ActiveRecord::Migration
  def change
    create_table :herba_transactions do |t|
    	t.references :herba_client, index: true
    	t.decimal :value, precision: 10, scale: 2
    	t.string :mode, limit: 10
    	t.string :description

      t.timestamps null: false
    end
  end
end
