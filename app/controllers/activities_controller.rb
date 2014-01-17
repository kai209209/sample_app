class ActivitiesController < ApplicationController
  def index
    @activities = Activity.find_unread_activities current_user
  end
end
