class CreateTaskLogs < ActiveRecord::Migration
  def change
    create_table :task_logs do |t|
      t.string :task_title
      t.string :starting_time
      t.string :ending_time

      t.timestamps null: false
    end
  end
end
