class Project < ActiveRecord::Base
  belongs_to :user

  # Not validating for presence of user because of preexisting sample data.
end
