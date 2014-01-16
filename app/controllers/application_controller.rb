class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def track_activity(trackable, action = params[:action])
    current_user.followers.each do |follower|
    current_user.activities.create! action: action, trackable: trackable, follower_user: follower.id   
    end
  end
end
