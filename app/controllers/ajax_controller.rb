class AjaxController < ApplicationController
before_action :logged_in_user

	def add_task
		t = Task.new(task_params)
		t.save
		render :nothing => true
  end

  def set_check
  	t = Task.find(params[:task_id])
  	t.done = params[:done]
  	t.save
  	render :nothing => true
  end

  def task_params
    params.require(:new_task).permit(:name, :date, :personal, :cat_id, :done)
  end

  def upd_param
    if params['model'] && params['model']!='undefined'

      obj = Object.const_get(params['model']).find(params['id'])
      prm = params[:upd]
      prm = params['upd'+params[:id]] if params[:upd].nil?
      prm.each do |p|
        pname = p[0]
        new_value = p[1]
        new_value.gsub!(' ','') if p[0]=='sum'  
        obj[pname] = new_value if p[0]!='undefined'
      end
      obj.save
    end
    render :nothing => true 
  end

end
