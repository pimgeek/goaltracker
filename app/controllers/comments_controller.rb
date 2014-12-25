class CommentsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :pre_load

  def pre_load
    @comment = Comment.find(params[:id]) if params[:id]

  end

  def comment_params
    params.require(:comment).permit(
      :user_id, :content, :topic_id
    )
  end



  def create
    @comment = Comment.create(comment_params)

    if @comment.save
      notice = Notice.create(
        :topicable => @comment, 
        :user_id => @comment.topic.user_id,
        :from_user_id => @comment.user_id)

      topic_id = @comment.topic_id

      EM.run {
        client = Faye::Client.new('http://localhost:3000/faye')

        user = @comment.topic.user

        notice_list = []
        notice_list << "<li><a href='/topics/#{topic_id}' style='color: red;'>#{notice.from_user.username} 给你发了一个消息，请查看</a></li>"

        client.publish("/topics/#{user.username}", 
          'notice_count' => "(<span>" + user.notices.count.to_s + "</span>)",
          'notice_list' => notice_list
        )
      }

      

      return redirect_to "/topics/#{topic_id}"
    end

    

    return render 'new'
  end


end