require 'spec_helper'

describe "educations/show" do
  before(:each) do
    @education = assign(:education, stub_model(Education,
      :resume_id => 1,
      :city => "City",
      :state => "State",
      :user_id => 2,
      :school_name => "School Name",
      :major => "Major",
      :since_year => "Since Year",
      :end_year => "End Year"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/2/)
    rendered.should match(/School Name/)
    rendered.should match(/Major/)
    rendered.should match(/Since Year/)
    rendered.should match(/End Year/)
  end
end
