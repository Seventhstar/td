class Task < ActiveRecord::Base
belongs_to :cat

  def cat_name_a
  	a = cat_id.nil? ? '' : cat.name[0]
  	a
  end

end
