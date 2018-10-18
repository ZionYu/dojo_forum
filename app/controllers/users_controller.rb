class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :post, :draft, :reply, :collect, :friend]

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
    
  end

  def draft
    @drafts = @user.posts.drafts
  end

  def reply
    
  end

  def collect
    
  end

  def friend
    
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar )
  end
end
