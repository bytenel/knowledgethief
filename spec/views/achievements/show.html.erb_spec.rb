require 'spec_helper'

describe "achievements/show" do
  before(:each) do
    @achievement = assign(:achievement, stub_model(Achievement,
      :summary => "Summary"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Summary/)
  end
end
