module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!
      def login
        user = User.find_by(email: params[:email])
        if user && user.valid_password?(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { user: user, token: token, message: 'User logged in successfully.' }
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def signup
        user = User.new(user_params)
        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user }, status: :created
        else
          render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      end

      def users
        users = User.all
        render json: { users: users.any? ? users : [], message: 'Users found successfully.' }
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
