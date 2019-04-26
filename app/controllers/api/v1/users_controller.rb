class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  before_action :find_user, only:[:update, :show]

  def index
    @users =  User.all
    render json: @users
  end

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end


  def show
    if @user
     render json: @user, status: :found
   else
     render json: { errors: ["User doesn't exist."] }, status: :not_found
   end
  end

  def create
    user_params_copy = user_params;
    user_interest = user_params[:interested_genders][0].split(',')
    user_params_copy.delete(:interested_genders)
    @user = User.new(user_params_copy)

    if @user.save
      user_interest.each do |gender_id|
        InterestedGender.create(user_id: @user.id, gender_id: gender_id)
      end
      @user.update(image_url: url_for(@user.image))

      @token = encode_token({ user_id: @user.id })
      render json: { user:  @user, jwt: @token }, status: :created
   else
     render json: { errors: @user.errors.full_messages }
   end
  end

  def update
    @user.update(user_params)
    if @user.save
     render json: @user, status: :created
   else
     render json: { errors: @user.errors.full_messages }
   end
  end

  private

  def user_params
    params.permit(:full_name, :email, :password, :password_confirmation, :gender_id, :coordinates, :date_of_birth, :image, interested_genders:[])
  end

  def find_user
    @user = User.find(params[:id])
  end

end
