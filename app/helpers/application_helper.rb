module ApplicationHelper

  def add_event_link
    if controller.current_timeline.nil?
      flash[:information] = "Please select a timeline to add an event to."
      return link_to 'Add Event', timelines_path
    else
      return link_to 'Add Event', new_timeline_event_path(controller.current_timeline)
    end
  end
end
