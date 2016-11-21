class LineItemsController < ApplicationController

  def new
    @line_item = LineItem.new
  end

  def create
    current_user.set_current_cart unless current_user.current_cart
    line_item = current_user.current_cart.add_item(params[:item_id])
    if line_item.save
      flash[:notice] = "Item successfully added to cart"

      redirect_to cart_path(current_user.current_cart)
    else
      flash[:alert] = "Unable to add item"

      redirect_to store_path
    end
  end

end
