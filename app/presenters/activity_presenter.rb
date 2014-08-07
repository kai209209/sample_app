class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def dynamic_class
<<<<<<< HEAD
    activity.unread current_user
=======
    activity.select_class current_user
>>>>>>> b3c806fafe732e82627da7e6052ac0e9bf5d0837
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