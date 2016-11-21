class CartsController < ApplicationController
  def index
    @carts = Cart.all
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
    @cart.save
    flash[:notice] = "Cart successfully created"

    redirect_to cart_path(@cart)
  end

  def edit
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.add_item(params["item_id"].to_i)
    @cart.save
    flash[:notice] = "Item successfully added"

    redirect_to cart_path(@cart)
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    flash[:notice] = "Cart successfully deleted"

    redirect_to items_path
  end

  def checkout
    @cart = Cart.find(params[:id])
    @cart.update_inventory_after_checkout
    current_user.delete_current_cart
    flash[:notice] = "Checkout successful"

    redirect_to cart_path(@cart)
  end

  private
    def cart_params
      params.require(:cart).permit(:user, :user_id, :item_id, :line_item_id)
    end
end
