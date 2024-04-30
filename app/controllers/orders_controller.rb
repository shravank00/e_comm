class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      @current_cart.cart_items.update_all(order_id: @order.id)
      @current_cart.destroy
      redirect_to root_path, notice: 'Order was successfully placed.'
    else
      redirect_to cart_path(@current_cart), alert: 'Order was not placed successfully.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:total_price, :status)
  end
end
