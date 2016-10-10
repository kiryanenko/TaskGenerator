json.extract! task, :id, :user, :title, :description, :task, :answer, :subject, :date, :removed, :created_at, :updated_at
json.url task_url(task, format: :json)