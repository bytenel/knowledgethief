require 'spec_helper'

describe "resumes/index" do
  before(:each) do
    assign(:resumes, [
      stub_model(Resume,
        :user_id => 1,
        :phone => "Phone",
        :address => "Address",
        :summary => "Summary"
      ),
      stub_model(Resume,
        :user_id => 1,
        :phone => "Phone",
        :address => "Address",
        :summary => "Summary"
      )
    ])
  end

  it "renders a list of resumes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
  end
end
