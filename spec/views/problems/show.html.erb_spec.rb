require "spec_helper"

describe "problems/show.html.erb" do

  before (:each) do
    assign(:problem, stub_model(Problem, :name => "slicer"))
    
  end

  it "should show the label" do
    render
    rendered.should =~ /Label:/
  end
end