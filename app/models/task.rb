class Task < ActiveRecord::Base
belongs_to :cat

  def cat_name_a
  	a = ''
  	a = cat.try(:name)[0] if !cat_id.nil? && cat_id!=0
  	a
  end

end
