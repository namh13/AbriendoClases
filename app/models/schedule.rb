class Schedule < ActiveRecord::Base
  attr_accessible :name
  has_many :requests
end