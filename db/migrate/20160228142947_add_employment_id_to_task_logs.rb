class AddEmploymentIdToTaskLogs < ActiveRecord::Migration
  def change
    add_column :task_logs, :employment_id, :integer
  end
end
