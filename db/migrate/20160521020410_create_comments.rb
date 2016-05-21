class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :poll, index: true, foreign_key: true
      t.string :body
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
