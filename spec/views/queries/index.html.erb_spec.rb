require 'spec_helper'

describe "minings/index" do
  before(:each) do
    assign(:minings, [
      stub_model(Mining,
        :verbatim => "Verbatim",
        :terms => "Terms"
      ),
      stub_model(Mining,
        :verbatim => "Verbatim",
        :terms => "Terms"
      )
    ])
  end

  it "renders a list of minings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Verbatim".to_s, :count => 2
    assert_select "tr>td", :text => "Terms".to_s, :count => 2
  end
end
