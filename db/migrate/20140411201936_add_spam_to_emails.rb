class AddSpamToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :spam, :boolean
  end
end
