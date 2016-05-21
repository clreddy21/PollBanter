class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile
      t.text :avatar
      t.boolean :is_active
      t.string :type

      t.timestamps null: false
    end
  end
end
