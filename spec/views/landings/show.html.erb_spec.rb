require 'spec_helper'

describe "landings/show" do
  before(:each) do
    @landing = assign(:landing, stub_model(Landing,
      :feature_id => 1,
      :feature_name => "Feature Name",
      :feature_class => "Feature Class"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Feature Name/)
    rendered.should match(/Feature Class/)
  end
end
