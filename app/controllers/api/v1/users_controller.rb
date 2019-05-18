class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :update_coordinates, :update]
  before_action :find_user, only:[:update, :show, :update_coordinates, :show_matches]

  def index
    @users =  User.all
    render json: @users
  end

  def profile
    @token = encode_token({ user_id: current_user.id })
    render json: { user: UserSerializer.new(current_user), jwt: @token }, status: :accepted
  end

  def show_matches
    if @user
      @active_matches = @user.active_matches
      render json: {active_matches: @active_matches }, status: :found
   else
     render json: { errors: ["User doesn't exist."] }, status: :not_found
   end
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
    @user = User.create(user_params_copy)

    if @user.valid?
      @user.update(image_url: url_for(@user.image))

      user_interest.each do |gender_id|
        InterestedGender.create(user_id: @user.id, gender_id: gender_id)
      end

      @token = encode_token({ user_id: @user.id })
      render json: { user:  UserSerializer.new(@user), jwt: @token }, status: :created
   else
     render json: { errors: @user.errors.messages }
   end
  end

  def update
    @user.image.purge # or user.avatar.purge_later
    @user.image.attach(user_params[:image])
    if @user.save
     @user.update(image_url: url_for(@user.image))
     render json: { user: UserSerializer.new(@user) }, status: :ok
   else
     render json: { errors: @user.errors.full_messages }
   end
  end

  def update_coordinates
    @user.update_attribute(:coordinates,  user_params[:coordinates])
    if @user.save
     render json: { user: UserSerializer.new(@user) }, status: :ok
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
