class ActivitiesController < ApplicationController

  def index
    @activities = Activity.find_activities current_user
  end

end
