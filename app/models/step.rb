class Step < ActiveRecord::Base
  belongs_to :elaboration
end
# == Schema Information
#
# Table name: steps
#
#  id             :integer         not null, primary key
#  index          :integer
#  justification  :text
#  selfcheck      :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  understood     :boolean
#  elaboration_id :integer
#

