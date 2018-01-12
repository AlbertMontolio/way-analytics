class SessionsController < Devise::SessionsController
	# we expand the create method from devise

	def create
		super
		user_info = sign_user_into_api
		# binding.pry
		session['authentication_token'] = user_info["authentication_token"]
	end

	private

	def sign_user_into_api
		# <ActionController::Parameters {"utf8"=>"✓", "authenticity_token"=>"8FqTqTONG+ACgAGiZ3wsOkVvo1EL8V/cvlDd7k4YzVH9clgbyxkFMUltG0HVAh9PPTfqT3fZWCiANeV5VzVH7A==", "user"=>{"email"=>"albert.montolio@waygroup.de", "password"=>"albert.montolio@waygroup.de", "remember_me"=>"0"}, "commit"=>"Log in", "controller"=>"sessions", "action"=>"create"} permitted: false>

		# after devise sign in, we have a params with [:user][:email], [:user][:password]
		email = user_params[:email]
		# password = encrypt_password(user_params[:password])
		password = user_params[:password]

		api_url = 'http://localhost:3000/users/sign_in.json'
		# .json this is to force devise to send us a json response, instead of the normal redirect 
		response = HTTParty.post(
			api_url, body: {
				user: {email: email, password: password}
			}
		)
		binding.pry
		JSON.parse(response.body)
	end

	def encrypt_password(password)
		#return password
		# binding.pry
		crypt = ActiveSupport::MessageEncryptor.new("test")
		encrypted_data = crypt.encrypt_and_sign(password)
		return encrypt_data
	end

	def user_params
		params.require(:user).permit(:email, :password)
	end 

end