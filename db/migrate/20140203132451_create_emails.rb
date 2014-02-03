class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :sender
      t.string :recipient
      t.string :subject
      t.text :body_plain
      t.text :body_html
      t.text :stripped_html
      t.boolean :answered, default: false
      t.boolean :read, default: false
      t.boolean :archived, default: false
      t.integer :conversation_id
      t.integer :user_id

      t.timestamps
    end
  end
end
