class CreateBanknotes < ActiveRecord::Migration[5.1]
  def change
    create_table :banknotes do |t|
      t.integer :kind
      t.integer :quantity

      t.timestamps
    end
  end
end
