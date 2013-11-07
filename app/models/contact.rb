class Contact
	def self.search(name, token)
		users_array = Array.new

		users = FbGraph::User.search(name, :access_token => token)

		users.each do |user|
			item = { name: user.name, fbid: user.identifier, email: user.email, picurl: "https://graph.facebook.com/#{user.identifier}/picture" }
			users_array << item
		end

		return users
	end
end