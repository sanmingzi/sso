module ApplicationHelper
  def flash_class(level)
    case level
      when :notice, 'notice' then "alert-info"
      when :success, 'success' then "alert-success"
      when :error, 'error' then "alert-danger"
      when :alert, 'alert' then "alert-danger"
    end
  end
end
