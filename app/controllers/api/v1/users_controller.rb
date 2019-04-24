class Api::V1::UsersController < ApplicationController

  before_action :find_user, only:[:update, :show]

  def index
    @users =  User.all
    render json: @users
  end

  def show
    if @user
     render json: @user, status: :found
   else
     render json: { errors: ["User doesn't exist."] }, status: :not_found
   end
  end

  def create
    @user = User.new(user_params)
    if @user.save
     render json: @user, status: :created
   else
     render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
   end
  end

  def update
    @user.update(user_params)
    if @user.save
     render json: @user, status: :created
   else
     render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
   end
  end

  private

  def user_params
    params.permit(:full_name, :email, :password, :password_confirmation, :gender, :coordinates, :date_of_birth, :image )
  end

  def find_user
    @user = User.find(params[:id])
  end

end
