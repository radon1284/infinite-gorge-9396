class AddTaskDateToTaskLogs < ActiveRecord::Migration
  def change
    add_column :task_logs, :task_date, :datetime
  end
end
