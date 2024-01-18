# app/controllers/tokens_controller.rb
class TokensController < ApplicationController
    before_action :authorize_request
  
    def refresh_token
      new_token = encode_token(current_user.id)
      render json: { newToken: new_token }, status: :ok
    end
  
    private
  
    def encode_token(user_id)
      JWT.encode({ user_id: user_id, exp: (Time.now + JWT_EXPIRATION).to_i }, Rails.application.secret_key_base, 'HS256')
    end
end
  