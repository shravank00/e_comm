module Api
  module V1
    class ProductsController < ApplicationController
      skip_before_action :authenticate_user!
      def index
        @products = Product.all
        if @products.any?
          render json: { products: @products }
        else
          render json: { error: 'There are no products available.' }
        end
      end

      def show
        @product = Product.find(params[:id])
        render json: { product: @product, description: @product.description }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Product not found' }, status: :not_found
      end
    end
  end
end
