class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
