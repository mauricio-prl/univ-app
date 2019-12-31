# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, except: %i[index new create]

  def index
    @courses = Course.order(:name)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to root_path, notice: 'Course successfully created.'
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @course.destroy
    redirect_to root_path, notice: 'Course successfully deleted.'
  end

  private

  def course_params
    params.require(:course).permit(:short_name, :name, :description)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
