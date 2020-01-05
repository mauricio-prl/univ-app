# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login
  before_action :logged_in_redirect, except: %i[destroy]

  def new; end

  def create
    student = Student.find_by(email: params[:session][:email])

    if student&.authenticate(params[:session][:password])
      session[:student_id] = student.id
      redirect_to student_path(student), notice: 'You have successfully logged in.'
    else
      flash.now[:alert] = 'There was something wrong with your login information.'
      render 'new'
    end
  end

  def destroy
    session[:student_id] = nil
    redirect_to root_path, notice: 'You have logged out.'
  end

  private

  def logged_in_redirect
    redirect_to root_path, alert: 'You are already logged in.' if logged_in?
  end
end
