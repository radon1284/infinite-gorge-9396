class AddUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_id, :integer
    add_column :users, :manager_id, :integer
    add_column :users, :team_leader_id, :integer
    
  end
end
