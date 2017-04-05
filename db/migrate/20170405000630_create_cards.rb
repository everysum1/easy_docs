class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :token
      t.references :card_product, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
