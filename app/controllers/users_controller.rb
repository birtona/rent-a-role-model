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
  end

  def show
    @user = User.find(params[:id])
  end
end
