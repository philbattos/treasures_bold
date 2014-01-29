require 'spec_helper'

describe "minings/edit" do
  before(:each) do
    @mining = assign(:mining, stub_model(Mining,
      :verbatim => "MyString",
      :terms => "MyString"
    ))
  end

  it "renders the edit mining form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mining_path(@mining), "post" do
      assert_select "input#mining_verbatim[name=?]", "mining[verbatim]"
      assert_select "input#mining_terms[name=?]", "mining[terms]"
    end
  end
end
