class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :token
      t.string :amount
      t.string :mid
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
