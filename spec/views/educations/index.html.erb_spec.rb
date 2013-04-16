require 'spec_helper'

describe "educations/index" do
  before(:each) do
    assign(:educations, [
      stub_model(Education,
        :resume_id => 1,
        :city => "City",
        :state => "State",
        :user_id => 2,
        :school_name => "School Name",
        :major => "Major",
        :since_year => "Since Year",
        :end_year => "End Year"
      ),
      stub_model(Education,
        :resume_id => 1,
        :city => "City",
        :state => "State",
        :user_id => 2,
        :school_name => "School Name",
        :major => "Major",
        :since_year => "Since Year",
        :end_year => "End Year"
      )
    ])
  end

  it "renders a list of educations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "School Name".to_s, :count => 2
    assert_select "tr>td", :text => "Major".to_s, :count => 2
    assert_select "tr>td", :text => "Since Year".to_s, :count => 2
    assert_select "tr>td", :text => "End Year".to_s, :count => 2
  end
end
