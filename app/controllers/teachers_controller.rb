# app/controllers/teachers_controller.rb
class TeachersController < ApplicationController
    # before_action :authenticate_teacher
  
    before_action :authorize_request
    def index
      @teachers = Teacher.all
      render json: @teachers
    end
  


    def show
      @teacher = Teacher.find_by(user_id: params[:id])
  
      if @teacher
        render json: @teacher
      else
        render json: { error: 'Teacher not found' }, status: :not_found
      end
    end


    def create
      teacher = Teacher.create!(user_id:params["user_id"],teacher_name:params["teacher_name"],phone_no:params["phone_no"])
      existing_teacher = Teacher.find_by(user_id: params["user_id"])
      if existing_teacher
        render json: { error: "Teacher with user_id: #{params['user_id']} already exists" }, status: :unprocessable_entity
      else  
        if teacher
          render json: teacher, status: :created
        else
          render json: { error: "Failed to create teacher" }, status: :unprocessable_entity
        end
      end
    end

  
    def destroy
      @teacher = Teacher.find(params[:id])
      if @teacher.destroy
        render json:{message: "Teacher deleted successfully"}, status:ok
      else
        render json:{error:"Failed to delete teacher"},status: :unprocessable_entity
      end


    private


    def teacher_params
      params.require(:teacher).permit(:user_id, :teacher_name, :phone_no)
    end
  end
end
  