module DashboardHelper

def my_helper
    total_hrs_by_date.each do |client|
      # content_tag(:tr)
      # content_tag(:td, :data => {:title => "Name" }) + client.full_name
      # content_tag(:td, :data => {:title => "Business Name" }) client.business_name
      # content_tag(:td, :data => {:title => "Total Time" })
      # c = ("%.2f" % client.hrs_this_month).to_s.split(".").map { |s| s.to_i }
      # a = c[0].to_s + ":" + ((c[1]*60)/100).to_s + " Hrs."
    end
  end
  
  def mhsn
  	arr = ["a", "b", "c"]
  		content_tag(:tr) do
  		  arr.each do |item|
  		  concat content_tag(:td, item)
  		end
  	end
  end


end

# <tr>
#   <td data-title="Name"><%= client.full_name %></td>
#   <td data-title="Business Name"><%= client.business_name %></td>
#   <td data-title="Month">
#   <%= 
#      c = ("%.2f" % client.hrs_this_month).to_s.split(".").map { |s| s.to_i }
#      a = c[0].to_s + ":" + ((c[1]*60)/100).to_s + " Hrs."
 
#   %></td>
# </tr>

