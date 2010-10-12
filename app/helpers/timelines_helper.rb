module TimelinesHelper

  def format_event_date(value)
    if value.nil?
      return "?"
    end

    return value.strftime('%B %d, %Y')
  end
end
