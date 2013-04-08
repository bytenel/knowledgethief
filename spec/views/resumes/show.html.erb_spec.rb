require 'spec_helper'

describe "resumes/show" do
  before(:each) do
    @resume = assign(:resume, stub_model(Resume,
      :user_id => 1,
      :phone => "Phone",
      :address => "Address",
      :summary => "Summary"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Phone/)
    rendered.should match(/Address/)
    rendered.should match(/Summary/)
  end
end
