class ShiftsController < ApplicationController
  before_action :get_current_user
  before_action :set_shift, only: [:update, :destroy, :show, :break_update]

  def index
    @shifts = Shift.where(organization_id:params[:org_id])
    render json: @shifts, status: 200 
  end

  def show  
    render json: @shift, status: 200 
  end

  def break_update  
  @shift.update(break:params[:break])
    #@shift.update(break:[params[:break]])
    render json: @shift, status: 200
  end

  def create    
    @shift = Shift.create(name:@current_user.username, date:params[:date], start:params[:start_time], finish:params[:finish_time], break:[params[:break]], active:true, user:@current_user, organization_id:params[:org_id])
  end 

  def update    
    @shift.update(date:params[:date], start:params[:start_time], finish:params[:finish_time])
    render json: @shift, status: 200
  end 

  def destroy    
    @deleted = @shift.destroy
    render json: @deleted, status: 200
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
    params.permit(:date,:start_time, :finish_time, :break, :user_email, :org_id, :shift_id)
  end
end
