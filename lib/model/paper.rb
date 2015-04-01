
class Paper < ActiveRecord::Base
  validates :title, presence: true
  validates :link_pdf, uniqueness: true
end
