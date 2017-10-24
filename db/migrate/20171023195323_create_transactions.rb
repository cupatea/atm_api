class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    enable_extension :hstore
    create_table :transactions do |t|
      t.hstore  :banknotes
      t.integer :amount
      t.integer :kind

      t.timestamps
    end
  end
end
