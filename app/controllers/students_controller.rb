# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, except: %i[index new create]

  def index
    @students = Student.order(:name)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to students_path, notice: 'Student successfully created.'
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: 'Student successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to students_path, notice: 'Student successfully deleted.' if @student.destroy
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :password)
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
