class Post < ActiveRecord::Base
  validates :content, presence: true, length: { minimum: 1, maximum: 140 }
end
