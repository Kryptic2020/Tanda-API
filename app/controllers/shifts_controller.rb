class ShiftsController < ApplicationController
  before_action :get_current_user
  before_action :set_shift, only: [:update, :destroy, :show, :break_update]

  def index
    @shifts = Shift.where(organization_id:params[:org_id],active:true).order(date: :desc)
    if @shifts
      render json: @shifts, status: 201
    else  
      render json: {error: "Shifts not found"}, status: 404
    end  
  end

  def inactive
    @shifts = Shift.where(organization_id:params[:org_id], active:false).order(date: :desc)
    if @shifts
      render json: @shifts, status: 201
    else  
      render json: {error: "Shifts not found"}, status: 404
    end  
  end

  def show  
    if @shift.errors.any? 
      render json: @shift.errors, status: :unprocessable_entity
    else  
      render json: @shift, status: 201
    end  
  end

  def break_update  
    @shift.update(break:params[:break])    
    if @shift.errors.any? 
      render json: @shift.errors, status: :unprocessable_entity
    else  
      render json: @shift, status: 201
    end  
  end

  def create    
    @shift = Shift.create(name:@current_user.username, date:params[:date], start:params[:start_time], finish:params[:finish_time], break:[params[:break]], active:true, user:@current_user, organization_id:params[:org_id])
    if @shift
      render json: @shift, status: 201
    else  
      render json: {error: "Could not create shift"}, status: 404
    end  
  end 

  def update    
    @shift.update(date:params[:date], start:params[:start_time], finish:params[:finish_time])
    if @shift.errors.any? 
      render json: @shift.errors, status: :unprocessable_entity
    else  
      render json: @shift, status: 201
    end  
  end 

  def destroy    
    @deleted = @shift.destroy
    if @deleted
      render json: @deleted, status: 201
    else  
      render json: {error: "Could not delete shift"}, status: 404
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
