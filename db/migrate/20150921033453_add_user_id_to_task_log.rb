class AddUserIdToTaskLog < ActiveRecord::Migration
  def change
    add_column :task_logs, :user_id, :integer
  end
end
