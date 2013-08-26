RSpec::Matchers.define :authorize do |*args|
	match do |permission|
		expect(permission.allow?(*args)).to be_true
	end
end