module Permissions
	class GuestPermission < BasePermission
		def initialize
			allow :home, [:index]
			allow :sessions, [:create, :destroy]
			allow :patients, [:new, :create]
			allow :doctors, [:new, :create]
			allow :password_resets, [:new, :create]
			allow :invites, [:switch]
		end
	end
end