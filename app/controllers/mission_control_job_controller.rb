class MissionControlJobController < ApplicationController
  before_action :validate_developer_logged_in

  private
  def validate_developer_logged_in
    unless current_user && current_user[:groups].include?("Developers")
      redirect_to "/", notice: "You must be a MythTV Developer to access Mission Control Job features."
    end
  end
end
