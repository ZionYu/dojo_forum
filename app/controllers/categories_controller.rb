class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @ransack = @category.posts.where(status: "published").ransack(params[:q])
    @posts = @ransack.result(distinct: true).page(params[:page]).per(20)
  end
end
