class Api::V1::MessagesController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
      message = Message.new(message_params)
      conversation = Conversation.where(id: message_params[:conversation_id]).take


      if message.save && conversation != nil
        serialized_data = ActiveModelSerializers::Adapter::Json.new(
          MessageSerializer.new(message)
        ).serializable_hash
        MessagesChannel.broadcast_to conversation, serialized_data
        head :ok
      else
        render json: { conversation: {id: message_params[:conversation_id] }} , :status => 404
      end

    end

    private

    def message_params
      params.require(:message).permit(:text, :conversation_id, :user_id)
    end
  end
