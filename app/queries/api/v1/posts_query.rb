class Api::V1::PostsQuery
  def initialize(search)
    @search = search
  end

  def call
    fetch_posts
  end

  private

  attr_reader :search

  def fetch_posts
    Post.where("category LIKE :ilike_search OR user_id == :eq_search", ilike_search: "%#{search}%", eq_search: search).order('posts.created_at DESC')
  end
end