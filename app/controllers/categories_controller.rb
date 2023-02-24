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
    @category.author = current_user
    if @category.save
      redirect_to root_path(@category), notice: 'Category Added successfully'
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_dealings = @category.dealings.order(created_at: :desc)
    @total = @category_dealings.sum(:amount)
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
