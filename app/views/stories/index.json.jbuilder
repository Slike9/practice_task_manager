json.array!(@stories) do |story|
  json.extract! story, :title, :description, :owner_id
  json.url story_url(story, format: :json)
end
