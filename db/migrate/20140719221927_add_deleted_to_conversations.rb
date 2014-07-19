class AddDeletedToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :deleted, :boolean, default: false
    add_column :emails, :deleted, :boolean, default: false
  end
end
