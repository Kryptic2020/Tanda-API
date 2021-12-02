class UsersController < ApplicationController

  def index
    render json:{Hello:"Welcome to Tanda Express"}
  end

  def show
    @current_user = User.find_by_email(params[:email]) 
    if @current_user
     render json: @current_user, status: 201
    else  
      render json:{error: "User not found"}, status: 404
    end  
  end

  def create
    @user = User.create(user_params)
    if @user.save
      auth_token = Knock::AuthToken.new payload: {sub: @user.id}
      UserNotifierMailer.welcome(@user).deliver
      render json:{username: @user.username, jwt:auth_token.token, user_id:@user.id}, status: 200
    else
      render json:{errors:"Email has already been taken"}
    end  
  end 

  def sign_in 
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      auth_token = Knock::AuthToken.new payload: {sub: @user.id} 
      render json:{username: @user.username, jwt:auth_token.token, user_id:@user.id} , status: 200
    else
      render json:{errors:"Email or password incorrect"}, status: 404
    end  
  end

  def forgot_pass
    @user = User.find_by_email(params[:email])
    if @user
      @token = SecureRandom.hex(13)
      @user.token = @token
      @user.save
      UserNotifierMailer.forgot_pass(@user, @token).deliver
      render json:{success:"We have sent you an email with the steps to reset your password"}, status: 200
    else
      render json:{errors:"Email invalid"}
    end  
  end

  def reset_pass
    @user = User.find_by_token(params[:token])
    @user.password = params[:password]
    @user.save   
    if @user
      render json:{msg:"Credentials successfuly saved, please login with your new password"}, status: 200
    else  
      render json:{msg:"Something went wrong, please try again later or contact the admin"}, status: 404
    end     
  end

  def update
    @user = User.find_by_id(params[:user_id])
    @user.password = params[:password]
    @user.username = params[:username]
    @user.email = params[:email]
    @user.save
    if @user
      render json:{msg:"Credentials successfuly saved"}, status: 200 
    else 
      render json:{msg:"Something went wrong, please try again later or contact the admin"}, status: 404
    end   
  end

  def user_params
    params.permit(:username,:email,:password,:password_confirmation,:token, :user_id)
  end
end
