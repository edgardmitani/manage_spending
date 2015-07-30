class CreateHomeTransactions < ActiveRecord::Migration
  def change
    create_table :home_transactions do |t|
    	t.references :home_client, index: true
    	t.references :home_category, index: true
    	t.decimal :value, precision: 10, scale: 2
    	t.string :mode, limit: 10
    	t.string :description

      t.timestamps null: false
    end
  end
end
