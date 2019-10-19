class InstructorsController < ApplicationController
  def show
    @instructor = Instructor.find(params[:instructor_id])
  end
end
