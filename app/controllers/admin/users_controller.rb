class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
    
  end

  def update
    @user = User.find(params[:id])
    @user.update(role: params[:role])
    if @user.save
      redirect_to admin_users_path
      flash[:notice] = "Authorization update succeeded"
    else
      flash[:alert] = "Not allow"
      render :index
    end
  end

  private
  def user_params
    params.require(:user).permint(:name, :eamil, :role)
  end

end
