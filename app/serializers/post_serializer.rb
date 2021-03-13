class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body, :category, :created_at

  attribute :body do |object|
    "#{object.body.truncate(500)}"
  end

  attribute :created_at do |object|
    "#{object.created_at.strftime('%F %T')}"
  end
end
