class  Api::V1::MatchesController < ApplicationController
  skip_before_action :authorized, only: [:show]

  def show
    @user = User.find(params[:id])
    render json: @user.active_matches, scope: nil
  end

end
