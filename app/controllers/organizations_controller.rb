class OrganizationsController < ApplicationController
  before_action :get_current_user
  before_action :set_org, only: [:show, :update, :destroy, :join, :leave]

  def index
    @orgs = Organization.all
    if @orgs
      render json: @orgs, status: 201
    else  
      render json: {error: "Organizations not found"}, status: 404
    end    
  end

  def show
    @org = Organization.find(params[:org_id])  
    if @org
        render json: @org, status: 201
      else  
        render json: {error: "Organization not found"}, status: 404
    end   
  end

  def update
    @org.update(name:params[:name], hourly_rate:params[:hourly_rate])        
      if @org.errors.any? 
          render json: @org.errors, status: :unprocessable_entity
      else  
        render json: @org, status: 201
      end 
  end

  def destroy
    @org.user_orgs.destroy_all
    @org.destroy    
    if @org.errors.any? 
      render json: @org.errors, status: :unprocessable_entity
    else  
      render json: @org, status: 201
    end   
  end

  def join
    @org.user_orgs.create(user:@current_user)
    Shift.where(user_id:@current_user.id).update(active:true)
    if @org.errors.any? 
      render json: @org.errors, status: :unprocessable_entity
    else 
      render json: @org, status: 201
    end   
  end

  def leave
    Shift.where(user_id:@org.user_orgs[0].user_id).update(active:false)
    @org.user_orgs.destroy_all
    if @org.errors.any? 
      render json: @org.errors, status: :unprocessable_entity
    else  
      render json: @org, status: 201
    end   
  end

  def joined
    @current_user.user_orgs.all
    if @current_user.errors.any? 
      render json: @current_user.errors, status: :unprocessable_entity
    else  
      render json: @current_user.organizations, status: 201
    end 
  end

  def create    
    @current_user.organizations.create(name:params[:name], hourly_rate:params[:hourly_rate])
    if @current_user.errors.any? 
      render json: @current_user.errors, status: :unprocessable_entity
    else  
      render json: @current_user, status: 201
    end   
  end 

  private

  def get_current_user
     begin
      @current_user = User.find_by_email(params[:user_email])  
    rescue
      render json: {error: "User not found"}, status: 404
    end
  end

  def set_org
    begin
      @org = Organization.find(params[:org_id])
    rescue
      render json: {error: "Organization not found"}, status: 404
    end 
  end

  def org_params
    params.permit(:name,:hourly_rate, :user_email, :org_id)
  end
end
