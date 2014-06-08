#encoding: utf-8
class ContactFormsController < ApplicationController
  #before_filter :valid_input, only: :create, except: :new
  def new
    @user = User.find(params[:user_id])
  end 

  def create  
    begin 
      @user = User.find(params[:user_id])
      #logger.debug("params in create #{params}")
      if (request.post? && valid_input(params))
        ContactFormMailer.contact_form_email(@user, params).deliver
        render :create
      else 
        flash.now[:error] = 'Fehler beim Versenden. Bitte prüfen Sie Ihre Angaben.' 
        render :new
      end 
    rescue ScriptError 
       flash[:error] = 'Sorry, this message appears to be spam and was not delivered.' 
    end
  end

  private 
  def valid_input params
    #logger.debug("params #{params.inspect}")
    valid = false
    if request.post?
      valid = (params[:name].present? && 
      params[:message].present? && 
      params[:school].present? && 
      params[:event].present? && 
      valid_email(params))
      #logger.debug("valid: #{valid.class}")
      return valid
    end
  end

  def valid_email(params)
    return (params[:email].present? && (params[:email] =~ /\A[\w\.%\+\-]+@[\w\-]+\.+[\w]{2,}\z/i))
  end
end