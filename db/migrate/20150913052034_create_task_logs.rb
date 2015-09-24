class CreateTaskLogs < ActiveRecord::Migration
  def change
    create_table :task_logs do |t|
      t.string :task_title
      t.time :starting_time
      t.time :ending_time

      t.timestamps null: false
    end
  end
end
