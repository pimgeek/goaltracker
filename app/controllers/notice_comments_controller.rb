class NoticeCommentsController < ApplicationController

  before_filter :authenticate_user!

  before_filter :pre_load

  def pre_load
    @notice_comment = NoticeComment.find(params[:id]) if params[:id]

  end

  def notice_comment_params
    params.require(:notice_comment).permit(
      :user_id, :content, :topic_id
    )
  end



  def create
    @comment = NoticeComment.create(notice_comment_params)

    topic_id = @comment.topic_id

    return redirect_to "/topics/#{topic_id}" if @comment.save

    return render 'new'
  end


end