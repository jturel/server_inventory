class AddRamMbToServer < ActiveRecord::Migration[7.0]
  def change
    add_column :servers, :ram_mb, :integer
  end
end
