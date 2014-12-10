class TopicsController < ApplicationController
  before_filter :authenticate_user!, 
              :except => [:show, :index]

  before_filter :pre_load

  def pre_load
    
  end

  def topic_params
    params.require(:topic).permit(
      :user_id, :title
    )
  end

  def index
  end

  def new
  end

  def create
    @talk_group = current_user.talk_groups.build(topic_params)

    return redirect_to "/topics" if @talk_group.save

    @talk_group.topics = TalkGroup.new.topics
    @talk_group.topics.build

    return render 'new'
  end


  def show
  end

  def edit
    return render_401 unless @talk_group.owner?(current_user)
  end


  def update
    return unless @talk_group.owner?(current_user)

    topic_list = params['topics']
    keys = topic_list.keys

    keys.each do |id|
      t = Topic.find(id)
      t.title = topic_list[id]['title']
      t.save
    end

    redirect_to "/topics/#{@talk_group.id}"

  end


  def search    
    @tag = params[:tag]
    @topic_by_tags = Topic.by_tag(@tag)
  end


end