class Hate < ActiveRecord::Base
  belongs_to :post, class_name: "Post"
end
