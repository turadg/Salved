require "spec_helper"

describe Problem do
  let(:problem) { Problem.new }

  it "should do something" do
    pending do
      #To change this template use File | Settings | File Templates.
      true.should == false
    end
  end

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
#  imageType    :string(255)
#

