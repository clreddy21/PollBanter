class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :uid
      t.string :provider
      t.string :accesstoken
      t.string :name
      t.string :nickname

      t.timestamps null: false
    end
  end
end
