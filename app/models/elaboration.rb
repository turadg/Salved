class Elaboration < ActiveRecord::Base
  belongs_to :problem
  
  has_many :steps, :order => "index ASC"
  accepts_nested_attributes_for :steps
  
  
end
# == Schema Information
#
# Table name: elaborations
#
#  id                 :integer         not null, primary key
#  status             :string(255)
#  difficulty         :integer
#  note_to_self       :text
#  note_to_instructor :text
#  created_at         :datetime
#  updated_at         :datetime
#  problem_id         :integer
#

