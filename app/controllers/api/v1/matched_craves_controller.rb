class Api::V1::MatchedCravesController < ApplicationController
  skip_before_action :authorized, only: [:update]

  def update
    @matched_crave = MatchedCrave.find(params[:id])

    if @matched_crave.update_attribute(:accepted_match, matched_crave_params[:accepted_match])

      @updated_active_matches = @matched_crave.match.update_status(matched_crave_params[:user_id])
      render json: { active_matches: @updated_active_matches }, status: :created
    else
     render json: { errors: @crave.errors.messages }
    end
  end

  private

  def matched_crave_params
    params.require(:matched_crave).permit(:user_id, :accepted_match)
  end

end
