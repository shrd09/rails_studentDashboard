
#For JWT
class SessionsController < ApplicationController
  skip_before_action :authorize_request, only: [:create, :destroy] # Bypass auth filter for login
  
  before_action :set_cors_headers

  def create
    user = User.find_by(email: params[:user][:email])

    puts "**********************************"
    puts "User Data: #{user.as_json(only: [:id, :email, :role])}"

    if user && user.authenticate(params[:user][:password]) 
      puts "User Data: #{user.as_json(only: [:id, :email, :role])}"
      # byebug
      jwt_token = generate_token(user.id)
      render json: { user: user.as_json(only: [:id, :email, :role]), token: jwt_token, message: 'Logged in successfully' }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    # reset_session
    render json: { message: 'Logged out successfully' }, status: :ok
  end


  private

  def generate_token(user_id)
    puts "Generating token for user_id: #{user_id}"
    user = User.find_by(id: user_id)
    return nil unless user

    expiration_time = 5.minutes.from_now.to_i# Set the expiration time
    payload = { user_id: user_id, email: user.email, exp: expiration_time }
    begin
      JWT.encode(payload,Rails.application.secret_key_base,'HS256')
    rescue JWT::EncodeError => e
      puts "Error encoding JWT: #{e.message}"
      nil
    end
  end

  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secret_key_base, 'HS256')
  end

  def set_cors_headers
    response.set_header('Access-Control-Allow-Origin', 'http://localhost:3001')
    response.set_header('Access-Control-Allow-Credentials', 'true')
    response.set_header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept, Authorization, Token')
    response.set_header('Access-Control-Allow-Methods', 'GET, POST, PATCH, PUT, DELETE, OPTIONS')
  end
end
