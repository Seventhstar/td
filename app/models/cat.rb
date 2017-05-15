class Cat < ActiveRecord::Base
  belongs_to :parent, class_name: "Cat"
  has_many :children, class_name: "Cat", foreign_key: "parent_id"

  

end
