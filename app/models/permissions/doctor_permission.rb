module Permissions
	class DoctorPermission < BasePermission
		def initialize
			allow :home, [:index]
			allow :sessions, [:create, :destroy]
			allow :doctors, [:show, :edit, :update, :destroy]
		end
	end
end