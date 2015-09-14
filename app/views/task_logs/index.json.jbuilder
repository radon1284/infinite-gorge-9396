json.array!(@task_logs) do |task_log|
  json.extract! task_log, :id, :task_title, :starting_time, :ending_time
  json.url task_log_url(task_log, format: :json)
end
