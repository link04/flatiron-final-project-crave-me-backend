class Api::V1::MenuChoicesController < ApplicationController
  skip_before_action :authorized
  
  def index
    @menu_choices = MenuChoice.all
    render json: @menu_choices
  end

end
