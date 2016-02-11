module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "BossDash"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  def first_name
  	name = current_user.meta.full_name.split(" ").map { |s| s.to_s }
    first_name = "#{name[0].to_s}"
  end
		
  def date_today
    today = Date.today
  end
end
