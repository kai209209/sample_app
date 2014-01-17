class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def track_activity(trackable, action = params[:action])
    activity = current_user.activities.create! action: action, trackable: trackable   
    track_notification activity
  end

  def track_notification(activity)
    current_user.followers.each do |follower|
      follower.notifications.create! activity: activity
    end
  end

end
