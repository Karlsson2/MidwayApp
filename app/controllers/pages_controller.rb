class PagesController < ApplicationController

  def home
    @navbar_visible = false
  end

  def dashboard

    participants = current_user.midways.last.midway_participants.where.not(user: current_user)


    @participant_string = ""
    participants.each_with_index do |participant, index|

    if index == participants.length - 1
        @participant_string << "& #{participant.user.first_name}"
      elsif index == participants.length - 2
        @participant_string << "#{participant.user.first_name} "
      else
        @participant_string << "#{participant.user.first_name}, "
      end
  end


end
end
