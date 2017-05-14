class AjaxController < ApplicationController

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

end
