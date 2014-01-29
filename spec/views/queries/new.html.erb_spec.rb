require 'spec_helper'

describe "minings/new" do
  before(:each) do
    assign(:mining, stub_model(Mining,
      :verbatim => "MyString",
      :terms => "MyString"
    ).as_new_record)
  end

  it "renders new mining form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", minings_path, "post" do
      assert_select "input#mining_verbatim[name=?]", "mining[verbatim]"
      assert_select "input#mining_terms[name=?]", "mining[terms]"
    end
  end
end
