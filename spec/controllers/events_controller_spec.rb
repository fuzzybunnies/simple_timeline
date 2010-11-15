require 'spec_helper'

describe EventsController do
  include Devise::TestHelpers

  before(:each) do
    @user = User.make!
    sign_in @user
  end

 
end
