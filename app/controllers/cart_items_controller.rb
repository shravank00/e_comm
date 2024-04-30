class CartItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    chosen_product = Product.find(params[:product_id])
    @cart_item = find_or_initialize_cart_item(chosen_product)

    if @cart_item.save
      redirect_to cart_path(@current_cart), notice: 'Product added to cart successfully'
    else
      redirect_to cart_path(@current_cart), alert: 'Failed to add product to cart'
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@current_cart), notice: 'Cart item removed successfully'
  end

  def add_quantity
    @cart_item = CartItem.find(params[:id])
    @cart_item.quantity += 1
    save_and_redirect('Quantity increased successfully')
  end

  def reduce_quantity
    @cart_item = CartItem.find(params[:id])
    @cart_item.quantity -= 1 if @cart_item.quantity > 1
    save_and_redirect('Quantity decreased successfully')
  end

  private

  def find_or_initialize_cart_item(product)
    if @current_cart.products.include?(product)
      @current_cart.cart_items.find_by(product_id: product).tap { |item| item.quantity += 1 }
    else
      CartItem.new(cart: @current_cart, product: product)
    end
  end

  def save_and_redirect(notice_message)
    if @cart_item.save
      redirect_to cart_path(@current_cart), notice: notice_message
    else
      redirect_to cart_path(@current_cart), alert: 'Failed to update cart item quantity'
    end
  end

  def record_not_found
    redirect_to cart_path(@current_cart), alert: 'Record not found'
  end
end
