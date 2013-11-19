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
      @users = User.order('name ASC').all(:conditions => { :city => @city })
    else
      @users = User.order('name ASC').all
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def contact_forms
    @user = User.find(params[:id])
  end
end
