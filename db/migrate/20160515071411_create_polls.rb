class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :name
      t.string :description
      t.string :vote_option_1
      t.string :vote_option_2
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
