class CreateSpams < ActiveRecord::Migration
  def change
    create_table :spams do |t|
      t.string :email

      t.timestamps
    end
  end
end
