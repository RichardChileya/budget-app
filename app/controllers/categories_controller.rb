class CategoriesController < ApplicationController
  def index
    @categories = Category.where(author: current_user).includes(:category_dealings).order(created_at: :desc)
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html { render :new, locals: { category: @category } }
    end
  end

  def create
    @category = Category.new(category_params)
    @category.author_id = params[:user_id]
    if @category.save
      redirect_to user_categories_path(params[:user_id]), notice: 'Category Added successfully'
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_dealings = CategoryDealing.includes(:dealing).where(category: @category).order(created_at: :desc)
    @total = 0
    @category_dealings.each { |z| @total += z.dealing.amount }
  end

  private

  def category_params
    params.require(:new_category).permit(:name, :icon)
  end
end
