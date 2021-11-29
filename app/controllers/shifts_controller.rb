class ShiftsController < ApplicationController
  before_action :get_current_user
  #before_action :set_shift, only: [:show, :update, :destroy, :join, :leave]

  def index
    @shifts = Shift.where(organization_id:params[:org_id])
    render json: @shifts, status: 200 
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
    @shift = Shift.create(name:@current_user.username, date:params[:date], start:params[:start_time], finish:params[:finish_time], break:[params[:break]], active:true, user:@current_user, organization_id:params[:org_id])
  end 


  private

  def get_current_user
    @current_user = User.find_by_email(params[:user_email])  
  end

  def set_shift
        begin
        @shift = Shift.find(params[:shift_id])
        rescue
            render json: {error: "Organization not found"}, status: 404
        end 
  end

  def shift_params
    params.permit(:date,:start_time, :finish_time, :break, :user_email, :org_id)
  end
end
