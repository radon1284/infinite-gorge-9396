class AddStaffIdToTaskLogs < ActiveRecord::Migration
  def change
  	add_column :task_logs, :staff_id, :integer
  end
end
