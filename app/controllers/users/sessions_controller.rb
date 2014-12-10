class Users::SessionsController < Devise::SessionsController
  # before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def create
    username = params['user']['username']
    user = User.where(username: username.downcase).first
    if user.nil?

      user = User.create(
        :username => username,
        :email => "#{username}@example.com",
        :password => 'password'
      )

      user.save
    end
    

    p params
    p user

    super
  end
end
