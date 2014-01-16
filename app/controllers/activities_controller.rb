class ActivitiesController < ApplicationController
  def index
    @activities = Activity.order("id desc")
  end
end
