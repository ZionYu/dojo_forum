class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end 
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "New category was successfully created"
      redirect_to admin_root_path
    else
      @categories = Category.all
      render :index
    end
  end

  

  def update
    @category.update(category_params)
    if @category.save
      redirect_to admin_root_path
      flash[:notice] = "Category was successfully update"
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_root_path
  end

  private

  def set_category
   @category = Category.find(params[:id]) 
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
