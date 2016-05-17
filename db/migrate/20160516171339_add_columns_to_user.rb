class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :string
    add_column :users, :avatar, :string
		add_column :users, :slug, :string
    add_index :users, :slug, unique: true
	end
end
