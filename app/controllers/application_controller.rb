class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
      unless logged_in?
        store_location
        # flash[:danger] = "Выполните вход."
        redirect_to login_url
      end
  end

  def store_path(obj,def_url = root_path)
    session['last_'+obj.name+'_page'] = request.url || def_url if request.get?
  end

  def last_page_url(obj)
    sess_url = session['last_'+obj.name+'_page']
    sess_url || root_path
  end


  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end



end
