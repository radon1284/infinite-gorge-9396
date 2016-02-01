class AddTaskDescriptionToTaskLogs < ActiveRecord::Migration
  def change
    add_column :task_logs, :task_description, :text
  end
end