class Api::ContactsController < ApplicationController
	before_action :check_key
	skip_before_action :check_key, only: [:auth]

	def check_key
		p 'checking the key'
		@token = session[:token]
		if(@token.nil?)
			render :json  => { success: :false, message: 'You must login first. ' }.to_json
		end
	end

	def auth
		provider = params[:provider]
		session[:token] = request.env["omniauth.auth"]["credentials"]["token"]
		render :json => true
	end

	def search
		search_term = params[:name]
		users = Contact.search(search_term, @token)
		render :json => { success: :true, payload: users }
	end

	def searchform
	end

end