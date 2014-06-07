class Admin::UserInformationsController < ApplicationController
  before_action :authenticate
  before_action ->(param=params[:user_id]) { authorize param }
  before_action :load_user
  # need authentication

  def new
    @info = @user.build_user_information
  end

  def create
    @info = @user.create_user_information(user_information_params)
    if @info
      redirect_to admin_user_user_information(@user, @info)
    else
      render 'new', alert: 'Es ist ein Fehler aufgetreten'
    end
  end

  def edit
    @info = @user.user_information
  end

  def update
    @info = @user.user_information
    if @info.update(user_information_params)
      redirect_to admin_user_user_information(@user, @info)  
    else
      render 'edit', alert: 'Es ist ein Fehler aufgetreten'
    end    
  end

  def destroy
    @info = @user.user_information
    @info.destroy
    redirect_to admin_user_user_information(@user, @info)
  end

  private
  def load_user
    @user = current_user
  end

  def user_information_params
    params.require(:user_information).permit(:why, :past, :projects, :places, :mentoring, :user_id)
  end

end
