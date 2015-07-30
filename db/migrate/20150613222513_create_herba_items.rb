class CreateHerbaItems < ActiveRecord::Migration
  def change
    create_table :herba_items do |t|
    	t.references :herba_client, index: true
    	t.references :herba_product, index: true
    	t.decimal :price, precision: 10, scale: 2
      t.decimal :profit, precision: 10, scale: 2
    	t.date :delivery_date
    	t.date :payment_date
    	t.date :product_date

      t.timestamps null: false
    end
  end
end
