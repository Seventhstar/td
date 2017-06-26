module OptionsHelper

  def get_active_option_page

  	case @page
  	when 'users'
  		1
    when 'cats'
      2
  	else
  		1
  	end
  			
  end

end
