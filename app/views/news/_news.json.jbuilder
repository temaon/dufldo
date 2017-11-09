json.extract! news, :id, :title, :short_description, :description, :created_at, :updated_at
json.url news_url(news, format: :json)