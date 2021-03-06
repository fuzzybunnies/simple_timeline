class TimelinesController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :edit, :create]

  # GET /timelines
  # GET /timelines.xml
  def index
    @timelines = Timeline.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timelines }
    end
  end

  # GET /timelines/1
  # GET /timelines/1.xml
  def show
    @timeline = Timeline.find(params[:id])
    self.current_timeline = @timeline
    sort_timeline_events
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timeline }
    end
  end

  def sort_timeline_events
    @timeline.events.sort! do |a, b| 
      date1 = a.event_date.nil? ? Date.new(1,1,1) : a.event_date
      date2 = b.event_date.nil? ? Date.new(1,1,1) : b.event_date
      comp = date1 <=> date2
      unless comp != 0
        comp = a.id.to_s <=> b.id.to_s
      end
      comp
    end
  end
  # GET /timelines/new
  # GET /timelines/new.xml
  def new
    @timeline = Timeline.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timeline }
    end
  end

  # GET /timelines/1/edit
  def edit
    @timeline = Timeline.find(params[:id])
    unless @timeline.user == current_user
      @action = 'edit this timeline.'
      render :template => 'shared/not_authorized' and return
    end
  end


  # POST /timelines
  # POST /timelines.xml
  def create
    @timeline = Timeline.new(params[:timeline])
    @timeline.user = current_user

    respond_to do |format|
      if @timeline.save
        format.html { redirect_to(@timeline, :notice => 'Timeline was successfully created.') }
        format.xml  { render :xml => @timeline, :status => :created, :location => @timeline }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timeline.errors, :status => :unprocessable_entity }
      end
    end
  end

end
