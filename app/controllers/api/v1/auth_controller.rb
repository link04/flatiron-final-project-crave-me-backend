class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user) , jwt: token }, status: :accepted
    else
      render json: { errors:  {password: ['Invalid Email or Password'] }}
    end
  end

  def show
    user_id = JWT.decode(request.headers["Authorization"], nil, false)[0]["user_id"]
    user = User.find(user_id)
    serialized_data = ActiveModelSerializers::Adapter::Json.new(
      UserSerializer.new(user)
    ).serializable_hash
    token = encode_token({ user_id: user.id })
    render json: { user: serialized_data[:user], jwt: token}
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
