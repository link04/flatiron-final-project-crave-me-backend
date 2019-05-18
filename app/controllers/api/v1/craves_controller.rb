class Api::V1::CravesController < ApplicationController

  def index
    @craves =  Crave.all_recent
    render json: @craves
  end

  def create
    @active_crave = Crave.user_recent(crave_params[:user_id])

    if @active_crave.count == 0
      @crave = Crave.create(crave_params)
      if @crave.valid?
        Crave.create_match_craved()
        @active_matches = @crave.user.active_matches

        render json: { crave: @crave, active_matches: @active_matches}, status: :created
      else
       render json: { errors: @crave.errors.messages }
      end
    else
      render json: { errors: ['User has active cravings!'] }
    end
  end

  private

  def crave_params
    params.require(:crave).permit(:user_id, :other, :main_course_id, :dessert_id, :drink_id)
  end

end
