require 'spec_helper'

describe "elaborations/edit.html.erb" do
  before(:each) do
    @elaboration = assign(:elaboration, stub_model(Elaboration,
      :status => "MyString",
      :difficulty => 1,
      :note_to_self => "MyText",
      :note_to_instructor => "MyText"
    ))
  end

  it "renders the edit elaboration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => elaborations_path(@elaboration), :method => "post" do
      assert_select "input#elaboration_status", :name => "elaboration[status]"
      assert_select "input#elaboration_difficulty", :name => "elaboration[difficulty]"
      assert_select "textarea#elaboration_note_to_self", :name => "elaboration[note_to_self]"
      assert_select "textarea#elaboration_note_to_instructor", :name => "elaboration[note_to_instructor]"
    end
  end
end
