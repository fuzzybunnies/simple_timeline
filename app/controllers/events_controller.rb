class EventsController < ApplicationController

  def new
    @event = Event.new
    @timeline = Timeline.find(params[:timeline_id])
    rescue
      redirect_to timelines_path

  end

  def create
    event = Event.new(params)

    if(event.save)
      redirect_to timeline_path(current_timeline)
    else
      @event = event
      render :template => :new
    end
  end
end
