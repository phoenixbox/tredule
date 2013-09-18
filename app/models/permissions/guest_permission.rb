module Permissions
	class GuestPermission < BasePermission
		def initialize
			allow :home, [:index]
			allow :sessions, [:create, :destroy]
			allow :patients, [:new, :create]
			allow :doctors, [:new, :create]
			allow :password_resets, [:new, :create]
			allow :invites, [:switch, :signup, :new_session, :create_and_associate, :login_and_associate]
		end
	end
end