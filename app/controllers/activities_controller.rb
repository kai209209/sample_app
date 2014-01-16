class ActivitiesController < ApplicationController
  def index
     @activities = Activity.where("follower_user = ?", current_user.id).order("id desc")
  end
end
