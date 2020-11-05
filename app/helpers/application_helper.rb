module ApplicationHelper
  def flash_class(level)
    case level
      when :notice, 'notice' then "alert-info"
      when :success, 'sucess' then "alert-success"
      when :error, 'error' then "alert-danger"
      when :alert, 'alert' then "alert-danger"
    end
  end
end
