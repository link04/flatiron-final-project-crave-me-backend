class Match < ApplicationRecord
  has_many :matched_craves, dependent: :destroy
  has_many :users, through: :matched_craves
  has_one :conversation, dependent: :destroy

  def update_status(user_id)
    if(self.matched_craves[0].accepted_match == false || self.matched_craves[1].accepted_match == false)
      self.update_attribute(:status, false)
      puts "love lost"
    elsif (self.matched_craves[0].accepted_match == true && self.matched_craves[1].accepted_match == true)
      self.update_attribute(:status, true)
      #  creating users comnversations after lovy dovy
       @conversation = Conversation.new(match_id: self.id)

      if @conversation.save
         serialized_data = ActiveModelSerializers::Adapter::Json.new(
           ConversationSerializer.new(@conversation)
         ).serializable_hash

         ActionCable.server.broadcast 'conversations_channel', serialized_data
         # head :ok
       end

      puts "love wins"
    end
    return User.find(user_id).active_matches
  end

  # herlper mthod for match and conversation testing must delete beg\fore producitons
  def self.restart_all_matches
    Match.all.each do | match |
      match.matched_craves.each do | matched_crave |
        matched_crave.update_attributes(accepted_match: nil)
      end
      match.update_attributes(status: nil)
    end
  end

  def matched_menu_choices
    menu_choices = []
    self.matched_craves[0].crave.as_json.each do | key1, value1 |
      self.matched_craves[1].crave.as_json.each do | key2, value2 |
        if key1 == key2 && value1 == value2
          if (key1 != 'other')
            menu_choices << MenuChoice.find(value1).name
          else
            menu_choices << value1
          end
        end
      end
    end
    return menu_choices
  end


end
