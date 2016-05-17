class AddColumnsToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :slug, :string
    add_index :polls, :slug, unique: true
    add_column :polls, :avatar_1, :string
    add_column :polls, :avatar_2, :string
  end
end
