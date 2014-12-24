class TopicsController < ApplicationController
  before_filter :authenticate_user!, 
              :except => [:show, :index]

  before_filter :pre_load

  def pre_load
    super

    @topic = Topic.find(params[:id]) if params[:id]
    @users = User.get_noticers(current_user)
  end

  def topic_params
    params.require(:topic).permit(
      :user_id, :content
    )
  end

  def index
    @topics = Topic.page params[:page]

  end

  def new
    @topic = Topic.new
  end

  def create
    noticers = params[:noticers]
    @topic = current_user.topics.build(topic_params)

    if @topic.save
      noticers.each { |t| TopicNoticer.create(:user_id => t, :topic => @topic) } if noticers
      
      return redirect_to "/topics"
    end

    return render 'new'
  end


  def show
    @notice = current_user.get_notice(@topic) if current_user
    @comment = Comment.new
  end

  def edit
    return render_401 unless @topic.owner?(current_user)
  end


  def update
    return unless @topic.owner?(current_user)

    @topic.update_attributes(topic_params)

    redirect_to "/topics/#{@topic.id}"

  end



end