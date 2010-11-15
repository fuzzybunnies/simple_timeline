class EventsController < ApplicationController

  before_filter :authenticate_user!

  def new
debugger
    @event = Event.new
    @timeline = Timeline.find(params[:timeline_id])

    unless @timeline.user == current_user
      @action = "to create a new event on this timeline because you're not the owner"
      render :template => 'shared/not_authorized' and return
    end

  end

  def create
    @timeline = current_timeline

    unless @timeline.user == current_user
      @action = "to add a new event to this timeline because you're not the owner"
      render :template => 'shared/not_authorized' and return
    end

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
    unless @timeline.user == current_user
      @action = 'edit this event because you are not the owner'
      render :template => 'shared/not_authorized' and return
    end
  end

  def update

    if timeline_and_event_are_valid?

      unless @timeline.user == current_user
        @action = "to update this event because you're not the owner"
        render :template => 'shared/not_authorized' and return
      end


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
