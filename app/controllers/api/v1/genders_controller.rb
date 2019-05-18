class Api::V1::GendersController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @genders = Gender.all
    render json: @genders
  end

end
