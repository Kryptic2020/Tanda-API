class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.save
      UserNotifierMailer.welcome(@user).deliver
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}
      render json:{username: @user.username, jwt:auth_token.token} , status: 200
    else
      render json:{errors:"Email has already been taken"}
    end  
  end 

  def sign_in
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}
      render json:{username: @user.username, jwt:auth_token.token} , status: 200
    else
      render json:{errors:"Email or password incorrect"}
    end  
  end

  def forgot_pass
    @user = User.find_by_email(params[:email])
    if @user
      @token = SecureRandom.hex(13)
      @user.token = @token
      @user.save
      UserNotifierMailer.forgot_pass(@user, @token).deliver
      render json:{success:"We have sent you an email with the steps to reset your password"} , status: 200
    else
      render json:{errors:"Email invalid"}
    end  
  end

  def reset_pass
    @user = User.find_by_token(params[:token])
    @user.password = params[:password]
    @user.save
    render json:{msg:"Credentials successfuly saved, please login with your new password"} , status: 200    
  end

  def user_params
    params.permit(:username,:email,:password,:password_confirmation)
  end
end
