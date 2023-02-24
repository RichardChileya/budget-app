class DealingController < ApplicationController
  def new
    @dealing = Dealing.new
    @categories = Category.where(author: current_user)
  end

  def create
    @dealing = Dealing.new(dealing_params)
    @dealing.author = current_user
    if @dealing.save
      CategoryDealing.create(dealing_id: @dealing.id, categoty_id: params[:category])
      redirect_to category_path(id: params[:category_id,]), notice: 'Transaction Added Successfuly'
    else render :new
    end
  end

  def destroy
    @dealings = Dealing.find(prams[:id])
    @dealings.destroy
    redirect_to category_path(id: params[:category_id]), alert: 'Transaction deleted successfully'
  end


  private

  def dealing_params
    params.require(:dealing).permit(:name, :amount, :category)
  end
end