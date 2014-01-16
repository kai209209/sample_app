class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def render_activity
    div_for activity do 
      link_to(activity.user.name, activity.user) + " " + render_partial + " " + link_to(follower.name, follower) + " " + "at #{activity.created_at}"
    end
  end

  def follower
    activity.user.followers.select{ |follower| follower[:id] == activity.follower_user }.first
  end

  def render_partial
    locals = { activity: activity, presenter: self }
    locals[activity.trackable_type.underscore.to_sym] = activity.trackable
    render partial_path, locals
  end

  def partial_path
    "activities/#{activity.trackable_type.underscore}"
  end
end