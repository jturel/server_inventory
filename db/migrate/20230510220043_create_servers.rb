class CreateServers < ActiveRecord::Migration[7.0]
  def change
    create_table :servers do |t|

      t.timestamps
    end
  end
end
