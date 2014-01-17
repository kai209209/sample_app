class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def dynamic_class
    activity.notifications.where(user_id: current_user.id ).first.read ?  "class1" : "class2"
  end

  def render_activity
      div_for(activity, class: dynamic_class) do 
        link_to(activity.user.name, activity.user) + " " + render_partial
      end
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