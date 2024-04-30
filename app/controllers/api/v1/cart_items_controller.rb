module Api
  module V1
    class CartItemsController < ApplicationController
      include Authenticatable
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!
      before_action :authorize_request
      before_action :find_product, only: [:create]

      def create
        current_cart = current_user.cart || current_user.create_cart
        @cart_item = current_cart.cart_items.find_or_initialize_by(product_id: @product.id)
        @cart_item.quantity += 1 if @cart_item.persisted?

        if @cart_item.save
          render json: { message: 'Product added to cart successfully', cart_items: current_cart.cart_items }, status: :created
        else
          render json: { error: @cart_item.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      end

      def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        render json: { message: 'Cart item removed successfully' }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Cart item not found' }, status: :not_found
      end

      private

      def find_product
        @product = Product.find(params[:product_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
      end
    end
  end
end
