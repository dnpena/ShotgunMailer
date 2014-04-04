class AddCcToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :cc, :string
    add_column :emails, :bcc, :string
  end
end
