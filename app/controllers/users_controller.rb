class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page:params[:page])
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
     flash[:success] = "Profile updated"
     sign_in @user
     redirect_to @user
    else
     render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
     if @user.save
       sign_in @user
       flash[:success] = "Welcome to the Sample App!"
	     redirect_to @user
     else
       render 'new'
      end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def upload_picture
    @picture = current_user.pictures.build(upload_picture_params)
    if @picture.save
      flash[:success] = '上传成功！'
      redirect_to root_path
    else
      flash.now[:danger] = '上传失败，请重新上传！'
      render 'static_pages/home'
    end
  end

  def destroy_picture
    @picture = Picture.find(params[:id])
    @picture.destroy
    flash[:success] = '删除成功！'
    redirect_to help_path
  end

  private
     def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation)
     end

     def correct_user
       @user = User.find(params[:id])
       redirect_to(root_path) unless current_user?(@user)
     end

     def admin_user
       redirect_to(root_path) unless current_user.admin?
     end

     def upload_picture_params
       params.require(:picture).permit(:name)
     end
end
