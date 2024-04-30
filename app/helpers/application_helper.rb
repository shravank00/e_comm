module ApplicationHelper
  def date_format(order)
    order&.created_at&.strftime('%b %d, %Y %I:%M %p')
  end
end
