class Api::V1::CommentsController < Api::BaseController
  skip_before_action :current_user, only: %i[index]
  before_action :get_post, only: %i[index create]
  before_action :get_comment, only: %i[destroy]

  def index
    @comments = @post.comments
    render json: @comments
  end

  def create
    @comment = @post.comments.create(comment_params)
    if @comment.save
      render json: @comment
    else
      render json: {
        messages: @comment.errors.messages
      }
    end
  end

  def destroy
    if @comment.user_id == current_user.id
      @comment.delete
    else
      render json: {
        messages: "Yo can't delete this post"
      }
    end
  end

  private

  def get_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def get_post
    @post = Post.find_by(id: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end