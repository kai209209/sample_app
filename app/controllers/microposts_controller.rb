class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def index

  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    @micropost.update(micropost_params)
    track_activity @micropost
    redirect_to current_user
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      track_activity @micropost
    	flash[:success] = 'Micropost created!'
    	redirect_to root_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
    	render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    track_activity @micropost
    redirect_to root_path
  end

  private

  def micropost_params
  	params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
