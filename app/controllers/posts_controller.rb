class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
    @categories = Category.all
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if params[:commit] == "Submit"
      @post.status = "publish"
      if @post.save
        flash[:notice] = "Post was published"
        redirect_to posts_path(@post)
      else
        flash.now[:alert] = "Post was failed to publish"
        render :new
      end
    elsif params[:commit] == "Save Draft"
      @post.status = "draft"
      if @post.save
        flash[:notice] = "Draft was saved"
        redirect_to posts_path(@post)
      else
        flash.now[:alert] = "Draft was failed to save"
        render :new
      end
    end     
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :image, :purview, :status,  category_ids: [])
  end
  
end
