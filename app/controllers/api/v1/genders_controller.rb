class Api::V1::GendersController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @genders = Gender.all
    render json: @genders
  end

  def show
    @gender = Gender.find(params[:id])
    if @gender
     render json: @gender, status: :found
   else
     render json: { errors: ["Gender doesn't exist."] }, status: :not_found
   end
  end

end
