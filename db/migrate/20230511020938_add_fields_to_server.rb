class AddFieldsToServer < ActiveRecord::Migration[7.0]
  def change
    add_column :servers, :hostname, :string, null: false, unique: true
    add_column :servers, :os, :string, null: false
    add_column :servers, :ip, :string, null: false, unique: true

    add_index :servers, :hostname
  end
end
