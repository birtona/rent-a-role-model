class ContactFormsController < ApplicationController

def new 
	@user = User.find(params[:user_id])
	@contact_form = ContactForm.new 
end 

def create	
	begin 
		@user = User.find(params[:user_id])
		@contact_form = ContactForm.new(params[:contact_form]) 
		@contact_form.user = @user
		@contact_form.request = request 
		if @contact_form.deliver 
		else 
			flash.now[:error] = 'Fehler beim Versenden. Bitte pruefen Sie Ihre Angaben.' 
			render :new 
		end 
	rescue ScriptError 
		flash[:error] = 'Sorry, this message appears to be spam and was not delivered.' 
		end 
	end 
end 