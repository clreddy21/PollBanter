class AddColummnsToUserAndPoll < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
    add_column :polls, :slug, :string
    add_index :polls, :slug, unique: true

  end
end
