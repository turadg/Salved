require 'spec_helper'

describe "elaborations/index.html.erb" do
  before(:each) do
    assign(:elaborations, [
      stub_model(Elaboration,
        :status => "Status",
        :difficulty => 1,
        :note_to_self => "MyText",
        :note_to_instructor => "MyText"
      ),
      stub_model(Elaboration,
        :status => "Status",
        :difficulty => 1,
        :note_to_self => "MyText",
        :note_to_instructor => "MyText"
      )
    ])
  end

  it "renders a list of elaborations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
