require 'spec_helper'

describe TimelinesController do
include Devise::TestHelpers

  before (:each) do
    @user = User.make!
    sign_in @user
  end

  def mock_timeline(stubs={})
    @mock_timeline ||= mock_model(Timeline, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all timelines as @timelines" do
      Timeline.stub(:all) { [mock_timeline] }
      get :index
      assigns(:timelines).should eq([mock_timeline])
    end
  end

  describe "GET show" do
    it "assigns the requested timeline as @timeline" do
      Timeline.stub(:find).with("37") { mock_timeline }
      get :show, :id => "37"
      assigns(:timeline).should be(mock_timeline)
    end
  end

  describe "GET new" do
    it "assigns a new timeline as @timeline" do
      Timeline.stub(:new) { mock_timeline }
      get :new
      assigns(:timeline).should be(mock_timeline)
    end
  end

  describe "GET edit" do
    it "assigns the requested timeline as @timeline" do
      Timeline.stub(:find).with("37") { mock_timeline }
      get :edit, :id => "37"
      assigns(:timeline).should be(mock_timeline)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created timeline as @timeline" do
        Timeline.stub(:new).with({'these' => 'params'}) { mock_timeline(:save => true) }
        post :create, :timeline => {'these' => 'params'}
        assigns(:timeline).should be(mock_timeline)
      end

      it "redirects to the created timeline" do
        Timeline.stub(:new) { mock_timeline(:save => true) }
        post :create, :timeline => {}
        response.should redirect_to(timeline_url(mock_timeline))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved timeline as @timeline" do
        Timeline.stub(:new).with({'these' => 'params'}) { mock_timeline(:save => false) }
        post :create, :timeline => {'these' => 'params'}
        assigns(:timeline).should be(mock_timeline)
      end

      it "re-renders the 'new' template" do
        Timeline.stub(:new) { mock_timeline(:save => false) }
        post :create, :timeline => {}
        response.should render_template("new")
      end
    end

  end


end
