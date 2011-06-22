class ProblemEvent < ActiveRecord::Base
  belongs_to :problem
  
  validates_presence_of :problem_id, :step, :name
  
end
