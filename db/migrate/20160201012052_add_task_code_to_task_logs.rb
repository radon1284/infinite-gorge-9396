class AddTaskCodeToTaskLogs < ActiveRecord::Migration
  def change
    add_column :task_logs, :task_code, :string
  end
end
