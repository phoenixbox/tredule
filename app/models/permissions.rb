module Permissions
	def self.permission_for(user)
		if user.nil?
			GuestPermission.new
		elsif user.class == Patient
			PatientPermission.new
		elsif user.class == Doctor
			DoctorPermission.new
		end
	end
end