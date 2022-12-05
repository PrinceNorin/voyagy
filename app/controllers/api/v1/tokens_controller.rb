class Api::V1::TokensController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      token = TokenService.encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: {
        code: 401,
        error: '401 Unauthorized'
      }, status: :unauthorized
    end
  end
end
