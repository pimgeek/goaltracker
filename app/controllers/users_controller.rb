class UsersController < Devise::RegistrationsController

  before_filter :find_user, only: [:show]


  def index
  end

  def show
    parse_tags
    
    @talk_groups = @user.talk_groups.page params[:page]
  end


  protected
    def find_user
      @user = User.where(username: params[:username].downcase).first

      render_404 if @user.nil?
    end


  

  
end