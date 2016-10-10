json.extract! question_card, :id, :user, :subject, :title, :description, :question_card, :date, :removed, :created_at, :updated_at
json.url question_card_url(question_card, format: :json)