class AddClientIdToTaskLogs < ActiveRecord::Migration
  def change
  	add_column :task_logs, :client_id, :integer
  end
end
