class Api::V1::PostsController < ApiController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :verify_identidy, only: [:update, :destroy]

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
    if !@post
      render json: {
        message: "Can't find the post",
        status: 400
      }
    else 
      render json: @post
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      render json: {
        message: "create post successfully",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    if @post.update(post_params)
      render json: {
        message: "post successfully updated",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post.destroy
    render json: {
      message: "post has deletd"
    }
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.permit(:title, :content, :image, :purview, :status, category_ids: [])
  end

  def verify_identidy
    unless @post.user == current_user
      render json: {
        errors: "Not allow"
      }
    end
  end
end
