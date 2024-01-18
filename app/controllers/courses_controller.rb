class CoursesController < ApplicationController
    # before_action :authorize_request, except: [:index, :show]
    before_action :authorize_request
    def show
        user_id = params[:id]
        courses = Course.where(user_id: user_id)
      
        puts "#{courses.inspect}"

        if courses.any?
          render json: courses, status: :ok
        else
          render json: { error: 'No courses for the signed-in teacher' }, status: :not_found
        end
    end

    # def show_marks
    #   courseId = params[:courseId]
    #   user_id = @current_user.id

    #   enrollment = Enrollment.find_by(user_id: user_id, course_id: courseId)

    #   if enrollment
    #     render json: {course_name: enrollment.course.course_name,marks: Array(enrollment.marks)}
    #   else
    #     render json: {error: 'Marks not found for the selected course'}, status: :not_found
    #   end
    # end

    def index
        courses = Course.includes(:teacher).all

        if courses.any?
        render json: courses, include: [:teacher], status: :ok
        else
        render json: { error: 'No courses available' }, status: :not_found
        end
    end

    def create
      course_name = params[:course_name]
      user_id = params[:user_id]

      course = Course.create!(course_name: course_name,user_id: user_id)

      if course
        render json: course, status: :created
      else
        render json: { error: "Failed to create course" }, status: :unprocessable_entity
      end 
    end
end
