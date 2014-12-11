class UsersController < Devise::RegistrationsController

  before_filter :find_user, only: [:show]


  def index
  end

  def show
    
    @topics = @user.topics.page params[:page]

    render 'topics/index'
  end


  protected
    def find_user
      @user = User.where(username: params[:username].downcase).first

      render_404 if @user.nil?
    end


  

  
end