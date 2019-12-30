class CoursesController < ApplicationController
  def index
    @courses = Course.order(:name)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
