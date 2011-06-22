class Problem < ActiveRecord::Base
  has_many :problem_events
  
  validates_presence_of :label, :filesPath, :step_count
  
end
