class CreateCardProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :card_products do |t|
      t.string :token
      t.string :name
      t.date :start_date

      t.timestamps
    end
  end
end
