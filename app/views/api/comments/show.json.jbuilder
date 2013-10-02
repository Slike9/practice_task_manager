json.extract! @comment, :body, :created_at
json.author do
  json.extract! @comment.author, :id, :email
end
