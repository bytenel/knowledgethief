require 'spec_helper'

describe "experiences/index" do
  before(:each) do
    assign(:experiences, [
      stub_model(Experience,
        :resume_id => 1,
        :user_id => 2,
        :institute_name => "Institute Name",
        :city => "City",
        :state => "State",
        :since_year => "Since Year",
        :end_year => "End Year",
        :title => "Title",
        :summary => "Summary"
      ),
      stub_model(Experience,
        :resume_id => 1,
        :user_id => 2,
        :institute_name => "Institute Name",
        :city => "City",
        :state => "State",
        :since_year => "Since Year",
        :end_year => "End Year",
        :title => "Title",
        :summary => "Summary"
      )
    ])
  end

  it "renders a list of experiences" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Institute Name".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Since Year".to_s, :count => 2
    assert_select "tr>td", :text => "End Year".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
  end
end
