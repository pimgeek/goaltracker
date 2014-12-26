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

      if noticers
        noticers.each do |t| 
          TopicNoticer.create(:user_id => t, :topic => @topic)
          notice = Notice.create(
            :user_id => t, 
            :from_user_id => @topic.user_id,
            :topicable => @topic)


          user = User.find(t)



          EM.run {
            client = Faye::Client.new(FAYE::URL)

            notice_list = []
            user.notices.each do |notice|
              notice_list << "<li><a href='/topics/#{notice.get_topicable_id}' style='color: red;'>#{notice.from_user.username} 给你发了一个消息，请查看</a></li>"
            end

            client.publish("/topics/#{user.username}", 
              'notice_count' => "(<span>" + user.notices.count.to_s + "</span>)",
              'notice_list' => notice_list
            )
          }
        end
      end

      return redirect_to "/topics"
    end

    return render 'new'
  end


  def show
    if current_user
      @was_noticed = current_user.was_noticed?(@topic)
      current_user.remove_notice(@topic)

      @topic.comments.each do |comment|
        current_user.remove_notice(comment)
      end
    end
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