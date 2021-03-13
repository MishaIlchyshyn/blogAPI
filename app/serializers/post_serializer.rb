class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :category, :created_at

  attribute :body do |object|
    "#{object.body.truncate(500)}"
  end
end
