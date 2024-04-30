module Api
  module V1
    class OrdersController < ApplicationController
      include Authenticatable
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!
      before_action :authorize_request

      def index
        orders = current_user.orders.order(created_at: :desc)
        if orders.any?
          render json: { orders: orders }
        else
          render json: { error: 'There are no orders placed.' }
        end
      end

      def create
        cart = current_user.cart || current_user.create_cart
        cart_items = cart.cart_items

        if cart_items.empty?
          render_empty_cart_error
          return
        end

        order = build_order(cart)
        save_order(order, cart, cart_items)
      end

      private

      def render_empty_cart_error
        render json: { error: 'Your cart is empty. Please add items to your cart before checking out.' }, status: :unprocessable_entity
      end

      def build_order(cart)
        current_user.orders.build(total_price: cart.sub_total, status: 'Ordered')
      end

      def save_order(order, cart, cart_items)
        if order.save
          cart_items.update_all(order_id: order.id)
          cart.destroy
          render json: { order: order.cart_items, total_price: order.total_price, message: 'Order placed successfully' }, status: :created
        else
          render json: { error: 'Failed to place order. Please try again.' }, status: :unprocessable_entity
        end
      end
    end
  end
end
