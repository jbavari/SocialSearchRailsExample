class Api::ContactsController < ApplicationController
	before_action :check_key
	skip_before_action :check_key, only: [:auth]

	def check_key
		p 'checking the key'
		@token = session[:token]
		if(@token.nil?)
			p ' no key was found.'
			render :json  => { success: :false, message: 'You must login first. ' }.to_json
		end
	end

	def auth
		provider = params[:provider]
		auth = request.env["omniauth.auth"]
		#raise auth.to_yaml

		token = auth["credentials"]["token"]

		p 'token: ' + token.to_s

		session[:token] = token

		render :json => true

	end

	def search
		search_term = params[:name]

		users_array = Array.new

		users = FbGraph::User.search(search_term, :access_token => @token)

		users.each do |user|
			item = { name: user.name, fbid: user.identifier, email: user.email, picurl: "https://graph.facebook.com/#{user.identifier}/picture" }

			users_array << item
		end

		render :json => { success: :true, payload: users_array }
	end

end
# Rector	Joshua	Strategic Team BJJ
# Bavari	Josh	American Elite MMA
# Wolf	Justin	Triton Fight Center Bixby
# Luksic	Michael	Guetho Texas
# Coppock	Michael	Lovato BJJ
# Irwin	Sebastian	Academy of Martial Arts
# Jordan	Virgil	Red River BJJ
# Young	William	Lovato BJJ