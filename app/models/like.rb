class Like < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  #one vote per recipe only
  validates_uniqueness_of :chef, scope: :recipe
end

