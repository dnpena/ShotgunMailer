class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.boolean :read, default: false
      t.boolean :archived, default: false
      t.boolean :answered, default: false
      t.string :subject

      t.timestamps
    end
  end
end
