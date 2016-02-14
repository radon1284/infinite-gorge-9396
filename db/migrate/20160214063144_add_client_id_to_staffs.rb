class AddClientIdToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :client_id, :integer
  end
end
