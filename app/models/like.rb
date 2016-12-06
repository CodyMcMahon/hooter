class Like < ActiveRecord::Base
  belongs_to :post, class_name: "Post"
  
end
