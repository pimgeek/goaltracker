class NoticeCommentsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :pre_load

  def pre_load
    @notice = Notice.find(params[:notice_id]) if params[:notice_id]
    @notice_comment = NoticeComment.find(params[:id]) if params[:id]

  end

  def notice_comment_params
    params.require(:notice_comment).permit(
      :notice_id, :user_id, :content, 
    )
  end



  def create
    @comment = NoticeComment.create(notice_comment_params)

    topic_id = @comment.notice.topic_id
    notice_id = @comment.notice_id

    return redirect_to "/topics/#{topic_id}?notice_id=#{notice_id}" if @comment.save

    return render 'new'
  end


end