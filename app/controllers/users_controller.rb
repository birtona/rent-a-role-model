class UsersController < ApplicationController
  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def edit
  end

  def index
    @city = params['city']

    if @city.present?
      @users = User.active.where(:city => @city ).order('name ASC')
    else
      @users = User.active.order('name ASC').all
    end
  end

  def show
    @user = User.active.find(params[:id])
    @info = @user.user_information
  end

  def contact_forms
    @user = User.active.find(params[:id])
  end
end
