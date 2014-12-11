class TopicsController < ApplicationController
  before_filter :authenticate_user!, 
              :except => [:show, :index]

  before_filter :pre_load

  def pre_load
    super

    @topic = Topic.find(params[:id]) if params[:id]
  end

  def topic_params
    params.require(:topic).permit(
      :user_id, :title1, :title2, :title3, :title4
    )
  end

  def index
    @topics = Topic.page params[:page]
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)

    return redirect_to "/topics" if @topic.save

    return render 'new'
  end


  def show
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