require 'spec_helper'

describe "landings/new" do
  before(:each) do
    assign(:landing, stub_model(Landing,
      :feature_id => 1,
      :feature_name => "MyString",
      :feature_class => "MyString"
    ).as_new_record)
  end

  it "renders new landing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", landings_path, "post" do
      assert_select "input#landing_feature_id[name=?]", "landing[feature_id]"
      assert_select "input#landing_feature_name[name=?]", "landing[feature_name]"
      assert_select "input#landing_feature_class[name=?]", "landing[feature_class]"
    end
  end
end
