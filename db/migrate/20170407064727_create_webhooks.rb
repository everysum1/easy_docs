class CreateWebhooks < ActiveRecord::Migration[5.0]
  def change
    create_table :webhooks do |t|
      t.string :url
      t.string :user
      t.string :password

      t.timestamps
    end
  end
end
