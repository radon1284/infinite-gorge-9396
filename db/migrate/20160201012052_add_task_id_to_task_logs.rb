class AddTaskIdToTaskLogs < ActiveRecord::Migration
  def change
    add_column :task_logs, :task_id, :string
  end
end
