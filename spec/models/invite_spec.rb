require 'spec_helper'

describe Invite do
  it{ should have_db_column(:recipient_type) }
end
