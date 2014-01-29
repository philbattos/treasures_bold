require 'spec_helper'

describe "minings/show" do
  before(:each) do
    @mining = assign(:mining, stub_model(Mining,
      :verbatim => "Verbatim",
      :terms => "Terms"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Verbatim/)
    rendered.should match(/Terms/)
  end
end
