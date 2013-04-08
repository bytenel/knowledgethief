require 'spec_helper'

describe "skills/show" do
  before(:each) do
    @skill = assign(:skill, stub_model(Skill,
      :resume_id => 1,
      :user_id => 2,
      :name => "Name",
      :summary => "Summary"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/Summary/)
  end
end
