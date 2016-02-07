class AddCompletedAtToTaskLogs < ActiveRecord::Migration
  def change
    add_column :task_logs, :completed_at, :datetime
  end
end
