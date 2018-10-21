class UsersController < ApplicationController
  before_action :set_user, except: [:accept, :ignore]

  def show
    
  end

  def edit
    unless @user = current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def post
    @published = @user.posts.published
  end

  def draft
    @drafts = @user.posts.drafts
  end

  def reply
    @replies = @user.replies
  end

  def collect
    @collects = @user.collects
  end

  def friend
    @waiting_for_responses = Friendship.where(user_id: @user.id, status: "pending")
    @requests = Friendship.where(friend_id: @user.id, status: "pending")
    @friendships = Friendship.where(user_id: @user.id, status: "accept").or(Friendship.where(friend_id: @user.id, status: "accept"))
  end

  def friend_request
    if current_user != @user 
      @friend_request = Friendship.new(user_id: current_user.id, friend_id: @user.id)
      @friend_request.save
    end
  end

  def friend_accept
    @friend_request = Friendship.find(params[:id])
    @friend_request.status = "accept"
    @friend_request.save
  end

  def friend_ignore
    @friend_request = Friendship.find(params[:id])
    @friend_request.status = "ignore"
    @friend_request.save
  end

  private

  def set_user
    @user = User.find(params[:id])
    return @user
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar )
  end
end
