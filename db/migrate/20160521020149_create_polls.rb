class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :name
      t.text :description
      t.string :vote_option_1
      t.string :vote_option_2
      t.text :avatar_1
      t.text :avatar_2
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
