json.extract! tasks_group, :id, :user, :subject, :title, :description, :created_at, :updated_at
json.url tasks_group_url(tasks_group, format: :json)
json.tasks do
  json.array! tasks_group.tasks, :id, :user, :subject, :title, :description, :task, :answer, :created_at, :updated_at
end