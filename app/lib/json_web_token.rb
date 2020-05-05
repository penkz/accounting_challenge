# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class << self
    def encode(payload)
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(token)
      JWT.decode(token, SECRET_KEY).first
    end
  end
end
