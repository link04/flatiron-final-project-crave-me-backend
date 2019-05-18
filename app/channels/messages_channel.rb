class MessagesChannel < ApplicationCable::Channel
  def subscribed
    puts 'chaneeeelss -----------------------------------'
    conversation = Conversation.find(params[:conversation])
    stream_for conversation
  end

  def unsubscribed
  end
end
