require 'spec_helper'

describe "rcomments/index" do
  before(:each) do
    assign(:rcomments, [
      stub_model(Comment,
        :content => "MyText",
        :user_id => 1,
        :resource_id => 2
      ),
      stub_model(Comment,
        :content => "MyText",
        :user_id => 1,
        :resource_id => 2
      )
    ])
  end

  it "renders a list of rcomments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
