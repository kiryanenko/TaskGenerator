json.extract! tasks_group, :id, :user, :subject, :title, :description, :date, :removed, :created_at, :updated_at
json.url tasks_group_url(tasks_group, format: :json)