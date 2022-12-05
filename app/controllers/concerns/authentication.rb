module Authentication
  extend ActiveSupport::Concern

  REALM = 'Bearer'

  included do
    before_action :authenticate_user!

    def current_user
      @current_user ||= _current_user
    end

    private

    def authenticate_user!
      unless current_user
        render json: {
          code: 401,
          error: '401 Unauthorized'
        }, status: :unauthorized
      end
    end

    def token
      header = request.headers[:authorization]
      if header
        realm, jwt = header.split(' ')
        return jwt if realm == REALM
      else
        params[:token].to_s
      end
    end

    def _current_user
      return unless token
      begin
        payload = TokenService.decode(token)
        User.find_by(id: payload[:user_id])
      rescue TokenService::InvalidToken
        nil
      end
    end
  end
end
