module ApplicationHelper

  def add_event_link
    if controller.current_timeline.nil?
      flash[:information] = "Please select a timeline to add an event to."
      return link_to 'Add Event', timelines_path
    else
      return link_to 'Add Event', new_timeline_event_path(controller.current_timeline)
    end
  end

  def format_event_date_info(event)
    if event.is_year_only
      return raw(" in #{event.event_date.strftime('%Y').sub(/^0+/, '')}")
    else
      return raw(" on #{format_event_date(event.event_date)}")
    end
  end
  def format_event_date(value)
    if value.nil?
      return "?"
    end

    return value.strftime('%B %d, %Y')
  end

end
