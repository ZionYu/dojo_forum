class Api::V1::PostsController < ApiController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.posts.published(current_user)
    else
      @posts = Post.published(current_user)
    end
    render json: { 
      data: @posts
    }
  end

  def show
    if != @post
      render json: {
        message: "Can't find the post"
        status: 400
      }
    else 
      render json: @post
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
