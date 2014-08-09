class AddSpamToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :spam, :boolean, default: false
  end
end
