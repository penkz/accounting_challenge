# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

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

  def not_found(e)
    render json: { error: e.message }, status: :not_found
  end
end
