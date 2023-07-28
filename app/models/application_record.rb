class ApplicationRecord < ActiveRecord::Base
  # the code in model will be available in the controller
  self.abstract_class = true
end
