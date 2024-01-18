class UsersController < ApplicationController
  before_action :authorize_request
  # , except: [:create]
  def index
    user = User.all.order(created_at: :desc)
    render json: user
  end

  def create
    # puts "Received parameters: #{params.inspect}"
    # puts "User params: #{user_params.inspect}"

    user = User.create!(email:params["email"],password:params["password"],role:params["role"]) 
    if user.valid?
      render json: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def delete_user
    email = params[:email]
    email = email+".com"
    puts "email of user: #{email}"
    user = User.find_by(email: email)
    # byebug
    user.destroy if user
    head :no_content
  end


  def show
    email = params[:email]
    user = User.find_by(email: email)
    puts "user params: #{user.inspect}"
    render json: user
  end

  def update
    email = params[:email]
    email = email+".com"
    user = User.find_by(email: email)
    puts "users data::***#{user}"
    # byebug
    if user
      update_payload = {
        password: params[:password],
        role: params[:role]
      }

      if user.update(update_payload)
        render json: {message: "User updated successfuly"}, status: :ok
      else
        render json: {error: "Failed to update user"}, status: :unprocessable_entity
      end
    else
      render json: {error: "User not found"}, status: :not_found
    end
  end
end
