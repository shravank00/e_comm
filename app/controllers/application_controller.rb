class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :current_cart
  before_action :check_mfa, if: :user_signed_in?

  private

  def check_mfa
    if !(user_mfa_session = UserMfaSession.find) && (user_mfa_session ? user_mfa_session.record == current_user : !user_mfa_session)
      current_user.set_google_secret unless current_user.google_secret_value
      redirect_to new_user_mfa_sessions_path
    end

    if destroy_user_session_path == request.path
      current_user.mfa_secret = nil
      current_user.save!
    end
  end

  def current_cart
    return nil unless current_user

    @current_cart = current_user.cart || current_user.create_cart
  end
end
