# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authenticate
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header

    begin
      decoded = JsonWebToken.decode(token)
      @current_account = Account.find(decoded['id'])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
