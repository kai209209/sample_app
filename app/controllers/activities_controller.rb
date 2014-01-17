class ActivitiesController < ApplicationController
  def index
    activity_ids = current_user.notifications.map(&:activity_id)
    @notifications = current_user.notifications.where(read: false)
    @notifications.update_all(read: true)
    @activities = Activity.order("id desc")
    @activities = @activities.where(id: activity_ids)
    @activities
  end
end
