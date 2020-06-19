class TopicsController < ApplicationController
  # before_action :login_check, {only: [:new]}
 
  def index
    @topics = Topic.all.includes(:favorite_users)
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = current_user.topics.new(topic_params)
    
    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  def index
    @topics = Topic.all.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def destroy
    @topic = Topic.find_by(id: params[:id])
    if @topic.user == current_user
      flash[:notice] = "投稿が削除されました" if @topic.destroy
    else
      flash[:alert] = "投稿の削除に失敗しました"
    end
    redirect_to topics_path
  end
  
  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
end