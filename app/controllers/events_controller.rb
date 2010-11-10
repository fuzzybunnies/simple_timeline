class EventsController < ApplicationController

  before_filter :authenticate_user!

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

    if e.valid? && @timeline.save
    
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

  def edit
    timeline_and_event_are_valid?
  end

  def update

    if timeline_and_event_are_valid?

      @event.write_attributes(params[:event])

      unless params[:event][:image].blank?
        @event.images << Image.new(params[:event][:image])
        @event.images.last.save
      end

      unless @event.save!
        render :template => "events/edit" and return
      end

    end
    

  end

  def timeline_and_event_are_valid?

    get_timeline

    if @timeline.nil?
      redirect_to root_path
      return false
    end

    @event = get_event_from_timeline

    if @event.nil?
      redirect_to timeline_path(@timeline)
      return false
    end

    return true
 end

  def get_timeline
    @timeline = nil
    begin
      @timeline = Timeline.find(params[:timeline_id])
    rescue
    end
  end

  def get_event_from_timeline
    events = @timeline.events.select{ |event| event.id.to_s == params[:id] }
    unless events.blank?
      return events.first
    end
    return nil
  end


end
