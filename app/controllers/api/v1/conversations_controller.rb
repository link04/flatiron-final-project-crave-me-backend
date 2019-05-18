class Api::V1::ConversationsController < ApplicationController
  skip_before_action :authorized, only: [:show]

  def show
    @conversations = User.find(params[:id]).conversations
    render json: @conversations
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    if @conversation.destroy
      render json: { conversation: @conversation }, status: :ok
    else
      render json: { conversation: @conversation.errors.messages}
    end

  end

  private

  def conversation_params
    params.require(:conversation_user).permit(:user_id)
  end

end
