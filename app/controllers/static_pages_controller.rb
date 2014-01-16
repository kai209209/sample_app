class StaticPagesController < ApplicationController
  def home
    if signed_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page])
    @picture = current_user.pictures.build
  end
  end

  def help
     @picture_items = current_user.feed_picture
  end

  def about
  end

  def contact
  end

end
