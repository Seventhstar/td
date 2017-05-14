json.extract! task, :id, :name, :date, :personal, :cat_id, :done, :created_at, :updated_at
json.url task_url(task, format: :json)
