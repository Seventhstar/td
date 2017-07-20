class Task < ActiveRecord::Base

  belongs_to :cat

  def cat_name_a
  	a = ''
  	a = try(:cat).try(:name)[0] if !cat.nil? && cat!=0
  	a
  end


  def cat_color
  	try(:cat).try(:color)
  end

  def cat_id
  	try(:cat).try(:id).to_s
  end
end
