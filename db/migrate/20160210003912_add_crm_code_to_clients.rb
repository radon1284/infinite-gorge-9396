class AddCrmCodeToClients < ActiveRecord::Migration
  def change
    add_column :clients, :crm_code, :string
  end
end
