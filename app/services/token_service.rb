class TokenService
  EXPIRES_IN = 24 * 3600
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  class InvalidToken < StandardError; end

  class << self
    def encode(payload, exp = EXPIRES_IN.seconds.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(token)
      payload = JWT.decode(token, SECRET_KEY)
      fail InvalidToken if payload.size == 0

      payload = HashWithIndifferentAccess.new(payload[0])
      fail InvalidToken if payload[:exp].to_i < DateTime.current.to_i
      payload
    rescue JWT::VerificationError, JWT::DecodeError
      fail InvalidToken
    end
  end
end
