class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :picture)
  end
end
