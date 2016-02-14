class AddManagerIdToStaffs < ActiveRecord::Migration
  def change
  	add_column :staffs, :user_id, :integer
    add_column :staffs, :manager_id, :integer
    add_column :staffs, :team_leader_id, :integer
  end
end
