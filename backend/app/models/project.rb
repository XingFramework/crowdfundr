class Project < ActiveRecord::Base
  has_many :pledges
end
