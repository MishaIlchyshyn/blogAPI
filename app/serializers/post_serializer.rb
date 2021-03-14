class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :body, :category, :created_at, :comments_count

  attribute :body do |post|
    "#{post.body.truncate(500)}"
  end

  attribute :created_at do |post|
    "#{post.created_at.strftime('%F %T')}"
  end

  attribute :comments_count do |post|
    "#{post.comments.count}"
  end
end
