json.extract! upload, :id, :name, :link, :reference, :archived, :user_id, :created_at, :updated_at
json.url upload_url(upload, format: :json)
