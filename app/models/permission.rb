class Permission < Struct.new(:user)
	def allow?(controller, action)
		return true if controller == "home" && action.in?(%w[index])
		return true if controller == "sessions" && action.in?(%w[create destroy])
		if user.nil?
			return true if controller == "patients" && action.in?(%w[new create])
			return true if controller == "doctors" && action.in?(%w[new create])
		elsif user.class == Patient
			return true if controller == "patients" && action.in?(%w[show edit update destroy])
		elsif user.class == Doctor
			return true if controller == "doctors" && action.in?(%w[show edit update destroy])
		end
		false
	end
end