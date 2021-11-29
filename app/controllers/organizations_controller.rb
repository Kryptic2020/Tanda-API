class OrganizationsController < ApplicationController
  before_action :get_current_user
  before_action :set_org, only: [:show, :update, :destroy, :join, :leave]

  def index
    @orgs = Organization.all
    render json: @orgs , status: 200 
  end

  def show
    @org = Organization.find(params[:org_id])
   
    render json: @org , status: 200 
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
    render json: @org, status: 201
  end

  def join
    @org.user_orgs.create(user:@current_user)  
    render json: @org, status: 201
  end

  def leave
    @org.user_orgs.destroy_all
    render json: @org, status: 201
  end

  def joined
    @joined = @current_user.user_orgs.all
    render json: @current_user.organizations, status: 201
  end

  def create    
    @new_org = @current_user.organizations.create(name:params[:name], hourly_rate:params[:hourly_rate])
  end 

  private

  def get_current_user
    @current_user = User.find_by_email(params[:user_email])  
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
