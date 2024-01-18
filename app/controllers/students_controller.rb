# app/controllers/students_controller.rb
class StudentsController < ApplicationController
    # before_action :authenticate_user!
    before_action :authorize_request
    # , except: [:create, :index, :show, :destroy]

    def index
      @students = Student.all
      render json: @students
    end


    def students_by_course
      course = Course.find(params[:course_id])
      students = course.students
      render json: students
    end
    

    def show
      @student = Student.find_by(user_id: params[:id])

      if @student
        render json: @student
      else
        render json: { error: 'Student not found' }, status: :not_found
      end
    end



    def create
      existing_student = Student.find_by(user_id: params["user_id"])
      if existing_student
        render json: { error: "Student with user_id: #{params['user_id']} already exists" }, status: :unprocessable_entity
      else    
        student = Student.create!(user_id:params["user_id"],student_name:params["student_name"],address:params["address"],age:params["age"])
          
        if student
          render json: student, status: :created
        else
          render json: { error: "Failed to create student" }, status: :unprocessable_entity
        end
      end
    end
  

    def destroy
      @student = Student.find(params[:id])

      if @student.destroy
        render json: { message: "Student deleted successfully" }, status: :ok
      else
        render json: { error: "Failed to delete student" },status: :unprocessable_entity 
    end

  end
end