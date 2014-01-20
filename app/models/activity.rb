class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true
  has_many :notifications

  def self.find_activities current_user
    activity_ids = current_user.notifications.map(&:activity_id)
    activities = Activity.order("id desc")
    activities = activities.where(id: activity_ids)
    activities
  end
 
  def select_class current_user
    notice = notifications.where(user_id: current_user.id ).first
    if notice.read 
      "class1" 
    else
      notice.update(read: true)
      "class2"
    end
  end
end
