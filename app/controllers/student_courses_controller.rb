# frozen_string_literal: true

class StudentCoursesController < ApplicationController
  def create
    course = Course.find(params[:course_id])

    if current_user.courses.include?(course)
      redirect_to root_path, alert: 'You already had enrolled this course.'
    else
      current_user.courses << course
      redirect_to root_path, notice: "You was successfully enrolled in #{course.name}."
    end
  end

  def destroy
    course = Course.find(params[:course_id])

    if current_user.courses.include?(course)
      current_user.courses.delete(course)
      redirect_to student_path(current_user),
        notice: "#{course.name} was successfully removed from your enrollments."
    else
      redirect_to root_path, alert: 'You had not enrolled this course yet.'
    end
  end
end
