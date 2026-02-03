class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    Rails.logger.debug "Session contents: #{session.to_hash.inspect}"
    info = session[:user_info]
    info.present? ? info.with_indifferent_access : nil
  end
end
