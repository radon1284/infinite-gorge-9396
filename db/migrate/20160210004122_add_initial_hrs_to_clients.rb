class AddInitialHrsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :initial_hrs, :float
  end
end
