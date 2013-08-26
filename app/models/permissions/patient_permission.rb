module Permissions
	class PatientPermission < BasePermission
		def initialize
			allow :home, [:index]
			allow :sessions, [:create, :destroy]
			allow :patients, [:show, :edit, :update, :destroy]
		end
	end
end