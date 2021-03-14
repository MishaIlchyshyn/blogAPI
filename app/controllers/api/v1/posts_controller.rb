class Api::V1::PostsController < Api::BaseController
  skip_before_action :current_user, only: %i[index show]
  before_action :get_post, only: %i[show destroy]

  def index
    @posts = Api::V1::PostsQuery.new(params[:search]).call
    render json: PostSerializer.new(@posts).serialized_json
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render json: @post
    else
      render json: {
        errors: @post.errors.full_messages
      }
    end
  end

  def show
    if @post
      render json: @post.as_json(only: [:title, :body, :category, :created_at])
    else
      render json: {
        errors: "Post not found"
      }
    end
  end

  def destroy
    if current_user.id == @post.user_id
      @post.destroy
      render json: {
        messages: "You deleted this post"
      }
    else
      render json: {
        errors: "You can't deleted this post"
      }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category)
  end

  def get_post
    @post = Post.find(params[:id])
  end
end