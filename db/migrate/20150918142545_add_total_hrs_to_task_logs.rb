class AddTotalHrsToTaskLogs < ActiveRecord::Migration
  def change
    add_column :task_logs, :total_hrs, :string
  end
end
