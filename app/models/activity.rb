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
<<<<<<< HEAD

  def unread current_user
    unread = notifications.where(user_id: current_user.id ).first
    if unread.read      
      "class1" 
    else
=======
 
  def select_class current_user
    notice = notifications.where(user_id: current_user.id ).first
    if notice.read 
      "class1" 
    else
      notice.update(read: true)
>>>>>>> b3c806fafe732e82627da7e6052ac0e9bf5d0837
      "class2"
    end
  end
end
