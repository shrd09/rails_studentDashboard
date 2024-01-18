# app/controllers/enrollments_controller.rb
class EnrollmentsController < ApplicationController
    # before_action :authenticate_user!
    before_action :authorize_request


    def create
        user_id = params["enrollment"]["user_id"]
        course_id = params["enrollment"]["course_id"]
        marks = params["enrollment"]["marks"] || 0
      

        if Enrollment.exists?(user_id: user_id, course_id: course_id)
            render json: { error: 'You are already in this course' }
            return
        end
        
        enrollment = Enrollment.create!(user_id: user_id, course_id: course_id, marks: marks)
      
        if enrollment
          render json: { message: 'Enrollment successful' }, status: :created
        else
          render json: { error: 'Failed to enroll in the course' }, status: :unprocessable_entity
        end
    end


    def show
        user_id = params[:id]
        @enrollment = Enrollment.where(user_id: user_id)
  
        if @enrollment
            render json: @enrollment, include: [:course]
        else
            render json: { error: 'Yet not enrolled in any courses' }, status: :not_found
        end
    end
      

    def index_by_courses
        puts "Params: #{params.inspect}"
        course_ids = params[:course_ids]&.split(',')
        puts "Course IDs: #{course_ids.inspect}"
      
        enrollments = Enrollment.where(course_id: course_ids).includes(student: [:user], course: [])

        render json: enrollments, include: { student: { include: { user: { only: [:id, :email] } }, only: [:id, :student_name] }, course: { only: [:id, :course_name] } }, only: [:id, :marks]
    end
      


    def index
        user_id = params[:id]
        enrollments = Enrollment.where(user_id: user_id).includes(:course)
        render json: enrollments, include: { course: { only: [:id, :course_name] } }, only: [:id, :marks]
    end


    def update_marks
        @enrollment = Enrollment.find(params[:id])

        if @enrollment.update(marks: params[:marks])
            render json: { message: 'Marks updated successfully' }, status: :ok
        else
            render json: { error: 'Failed to update marks' }, status: :unprocessable_entity
        end
    end

    
    # private
    # def enrollment_params
    #     params.require(:enrollment).permit(:user_id, :course_id, :marks)
    # end
end
  