
class Paper < ActiveRecord::Base
  validates :id, presence: true
  validates :title, presence: true
end

