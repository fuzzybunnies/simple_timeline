class EventsController < ApplicationController

  def new
    @event = Event.new
    @timeline = Timeline.find(params[:timeline_id])
    rescue
      redirect_to timelines_path

  end

  def create
    @timeline = current_timeline
    e = Event.new(params[:event])
    @timeline.events << e

    if @timeline.save
    
      unless params[:event][:image].blank?
        i = Image.new(params[:event][:image])
        e.images << i
        @timeline.events.last.images.last.save
      end

      redirect_to timeline_path(@timeline)
    else
      @event = e
      render :template => "events/new"
    end
  end
end
