# frozen_string_literal: true

class StudentsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_student, except: %i[index new create]
  before_action :require_owner, only: %i[edit update destroy]
  before_action :require_logout, only: %i[new]

  def index
    @students = Student.order(:name)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      session[:student_id] = @student.id
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
    if @student.destroy
      session[:student_id] = nil
      redirect_to login_path, notice: 'Student successfully deleted.'
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end

  def require_owner
    unless current_user == @student
      redirect_to student_path(current_user), alert: 'You can do this with your own account.'
    end
  end

  def require_logout
    redirect_to students_path, alert: 'You must to logout first.' if logged_in?
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
