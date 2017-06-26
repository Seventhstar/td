module OptionsHelper

  def get_active_option_page

  	case @page
  	when 'users'
  		0
    when 'cats'
      1
  	else
  		4
  	end
  			
  end

end
