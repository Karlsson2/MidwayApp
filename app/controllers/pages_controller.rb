class PagesController < ApplicationController
  def home
    @navbar_visible = false
  end

  def dashboard
    if current_user.midways.count > 0
      all_participants = current_user.midways.last.midway_participants
      participants = []
      all_participants.each do |participant|
        participants.push(participant.user.first_name) if participant.user && participant.user_id != current_user.id
        participants.push(participant.guest.name) if participant.guest
      end
      @participant_string = ""
      participants.each_with_index do |participant, index|
        if index == participants.length - 1
          @participant_string << "& #{participant}"
        elsif index == participants.length - 2
          @participant_string << "#{participant} "
        else
          @participant_string << "#{participant}, "
        end
      end
    end
  end
end
