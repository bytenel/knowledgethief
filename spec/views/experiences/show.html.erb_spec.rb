require 'spec_helper'

describe "experiences/show" do
  before(:each) do
    @experience = assign(:experience, stub_model(Experience,
      :resume_id => 1,
      :user_id => 2,
      :institute_name => "Institute Name",
      :city => "City",
      :state => "State",
      :since_year => "Since Year",
      :end_year => "End Year",
      :title => "Title",
      :summary => "Summary"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Institute Name/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Since Year/)
    rendered.should match(/End Year/)
    rendered.should match(/Title/)
    rendered.should match(/Summary/)
  end
end
