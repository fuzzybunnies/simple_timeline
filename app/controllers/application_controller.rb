class ApplicationController < ActionController::Base
  protect_from_forgery


  def current_timeline=(timeline)
    unless timeline.nil?
      session["timeline_id"] = timeline.id
    end
  end
  def current_timeline
    unless session["timeline_id"].blank?
      return Timeline.find(session["timeline_id"])
    end
    nil
  end
end
