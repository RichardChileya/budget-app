class DealingsController < ApplicationController
  def new
    @dealing = Dealing.new
    @categories = Category.where(author: current_user)
  end

  def create
    @dealing = Dealing.new(dealing_params)
    @dealing.author = current_user
    if @dealing.save
    @cd =CategoryDealing.create(dealing_id: @dealing.id, category_id: params[:category])
      redirect_to category_path(@cd.category), notice: 'Transaction Added Successfuly'
    else
      render :new
    end
  end

  def destroy
    @dealings = Dealing.find(prams[:id])
    @dealings.destroy
    redirect_to category_path(id: params[:category_id]), alert: 'Transaction deleted successfully'
  end

  private

  def dealing_params
    params.require(:dealing).permit(:name, :amount)
  end
end
