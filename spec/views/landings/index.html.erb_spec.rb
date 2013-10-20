require 'spec_helper'

describe "landings/index" do
  before(:each) do
    assign(:landings, [
      stub_model(Landing,
        :feature_id => 1,
        :feature_name => "Feature Name",
        :feature_class => "Feature Class"
      ),
      stub_model(Landing,
        :feature_id => 1,
        :feature_name => "Feature Name",
        :feature_class => "Feature Class"
      )
    ])
  end

  it "renders a list of landings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Feature Name".to_s, :count => 2
    assert_select "tr>td", :text => "Feature Class".to_s, :count => 2
  end
end
