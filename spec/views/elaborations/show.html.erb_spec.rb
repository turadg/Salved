require 'spec_helper'

describe "elaborations/show.html.erb" do
  before(:each) do
    @elaboration = assign(:elaboration, stub_model(Elaboration,
      :status => "Status",
      :difficulty => 1,
      :note_to_self => "MyText",
      :note_to_instructor => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
