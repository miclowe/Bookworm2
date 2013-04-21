class Book < ActiveRecord::Base
  attr_accessible :author, :cover_url, :description, :isbn, :published_on, :title, :work_id, :gr_id

  has_many :bookbags
  has_many :users, :through => :bookbags
  
end
