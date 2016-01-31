class AddMultiplierToClients < ActiveRecord::Migration
  def change
    add_column :clients, :multiplier, :float
  end
end
