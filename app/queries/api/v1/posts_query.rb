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
    Post.where("category LIKE :search", search: "%#{search}%")
  end
end