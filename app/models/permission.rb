class Permission
	def initialize(user)
		allow :home, [:index]
		allow :sessions, [:create, :destroy]
		if user.nil?
			allow :patients, [:new, :create]
			allow :doctors, [:new, :create]
		elsif user.class == Patient
			allow :patients, [:show, :edit, :update, :destroy]
		elsif user.class == Doctor
			allow :doctors, [:show, :edit, :update, :destroy]
		end
		false
	end

	def allow?(controller, action)
		@allow_all || @allowed_actions[[controller.to_s, action.to_s]]
	end

	def allow_all
		@allow_all = true
	end

	def allow(controllers, actions)
		@allowed_actions ||= {}
		Array(controllers).each do |controller|
			Array(actions).each do |action|
				@allowed_actions[[controller.to_s, action.to_s]] = true
			end
		end
	end

end