require 'spec_helper'

describe User do
  it 'should have timestamps' do
    u = User.new
    u.respond_to?(:created_at).should be_true
    u.respond_to?(:updated_at).should be_true
  end
end
