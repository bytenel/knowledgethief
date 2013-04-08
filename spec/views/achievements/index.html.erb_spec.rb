require 'spec_helper'

describe "achievements/index" do
  before(:each) do
    assign(:achievements, [
      stub_model(Achievement,
        :summary => "Summary"
      ),
      stub_model(Achievement,
        :summary => "Summary"
      )
    ])
  end

  it "renders a list of achievements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
  end
end
