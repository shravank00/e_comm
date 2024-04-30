class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :current_cart

  private

  def current_cart
    return nil unless current_user

    @current_cart = current_user.cart || current_user.create_cart
  end
end
