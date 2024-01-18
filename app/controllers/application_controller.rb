class ApplicationController < ActionController::Base
    before_action :authorize_request
    protect_from_forgery with: :null_session
  
    def get_csrf_token
        render json: { csrfToken: form_authenticity_token }
    end

    def authorize_request
      header = request.headers['Authorization']
      token = header.split(' ').last if header
      puts "Received token in headers: #{token}"
  
      if token
        authenticate_token(token)
      else
        render json: { error: 'Token not provided' }, status: :unauthorized
      end
    end
  
    private
  
    def authenticate_token(token)
        begin
          decoded = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
          puts "Decoded token: #{decoded}"

          if decoded[0]['exp'].present? && Time.now.to_i > decoded[0]['exp']
            render json: { error: 'Token has expired' }, status: :unauthorized
          else
            @current_user = User.find(decoded.first['user_id'])
          end
          rescue JWT::ExpiredSignature
            render json: { error: 'Token has expired' }, status: :unauthorized
          rescue JWT::DecodeError
            render json: { error: 'Invalid token' }, status: :unauthorized
        end
    end
end
  