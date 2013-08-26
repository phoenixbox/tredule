module Permissions
	class GuestPermission < BasePermission
		def initialize
			allow :home, [:index]
			allow :sessions, [:create, :destroy]
			allow :patients, [:new, :create]
			allow :doctors, [:new, :create]
		end
	end
end