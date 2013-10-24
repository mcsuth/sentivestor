class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
			t.string :tickersymbol
    	t.string :company
    	t.integer :user_id
      t.timestamps
    end
  end
end
