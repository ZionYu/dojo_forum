class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :collect, :uncollect] 

  def index
    @categories = Category.all
    @ransack = Post.where(status: 'published').order(id: :desc).ransack(params[:q])
    @posts = @ransack.result(distinct: true).page(params[:page]).per(20)
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if params[:commit] == "Submit"
      @post.status = "published"
      if @post.save
        flash[:notice] = "Post was published"
        redirect_to post_path(@post)
      else
        flash.now[:alert] = "Post was failed to publish"
        render :new
      end
    elsif params[:commit] == "Save Draft"
      @post.status = "draft"
      if @post.save
        flash[:notice] = "Draft was saved"
        redirect_to draft_user_path(current_user)
      else
        flash.now[:alert] = "Draft was failed to save"
        render :new
      end
    end     
  end

  def show
    purview_check(@post, current_user)
    @user = @post.user
    @reply = Reply.new(user: current_user)
    @replies = @post.replies.page(params[:page]).per(20)
    @post.pageviews
  end

  def edit
    if current_user == @post.user

    else
      redirect_to post_path(@post.id)
    end
  end

  def update
    if params[:commit] == "Submit"
      @post.status = 'published'
      if @post.update(post_params)
        flash[:notice] = "post was successfully updated"      
        redirect_to post_path(@post)
      else
        flash.now[:alert] = "post was failed to update"
        render :edit
      end
    elsif params[:commit] == "Save Draft"
      if @post.update(post_params)
        flash[:notice] = "draft was successfully updated"      
        redirect_to draft_user_path(@post.user)
      else
        flash.now[:alert] = "draft was failed to update"
        render :edit
      end
    end
  end

  def destroy
    if current_user.role == "Admin" || current_user == @post.user
      if @post.status == 'draft'
        @post.destroy
        redirect_to draft_user_path(current_user)
        flash[:alert] = "draft was deleted"  
      else   
        @post.destroy
        redirect_to post_user_path(@post.user)
        flash[:alert] = "post was deleted"
      end
    end
  end

  def collect
    Collect.create!(user: current_user, post: @post)
  end

  def uncollect
    collects = Collect.where(user: current_user, post: @post)
    collects.destroy_all  
  end

  def feeds
    @users_count = User.count
    @posts_count = Post.count
    @replies_count = Reply.count
    @users = User.order(replies_count: :desc).first(10)
    @posts = Post.order(replies_count: :desc).first(10)
  end
  

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :purview, :status,  category_ids: [])
  end
  
  
end
