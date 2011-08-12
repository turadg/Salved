class Problem < ActiveRecord::Base
  has_many :problem_events
  has_many :elaborations
  
  validates_presence_of :label, :filesPath, :step_count
  
  
end
# == Schema Information
#
# Table name: problems
#
#  id           :integer         not null, primary key
#  label        :string(255)
#  filesPath    :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  step_count   :integer
#  explanations :text
#

