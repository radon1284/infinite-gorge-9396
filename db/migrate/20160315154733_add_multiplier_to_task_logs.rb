class AddMultiplierToTaskLogs < ActiveRecord::Migration
  def change
    add_column :task_logs, :multiplier, :float
  end
end
