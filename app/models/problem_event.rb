class ProblemEvent < ActiveRecord::Base
  belongs_to :problem
  
  validates_presence_of :problem_id, :step, :name
  
end
# == Schema Information
#
# Table name: problem_events
#
#  id         :integer         not null, primary key
#  problem_id :integer
#  step       :integer
#  name       :string(255)
#  value      :text
#  ip_address :string(255)
#  created_at :datetime
#  updated_at :datetime
#

