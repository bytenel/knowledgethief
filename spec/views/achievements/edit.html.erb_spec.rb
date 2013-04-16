require 'spec_helper'

describe "achievements/edit" do
  before(:each) do
    @achievement = assign(:achievement, stub_model(Achievement,
      :summary => "MyString"
    ))
  end

  it "renders the edit achievement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", achievement_path(@achievement), "post" do
      assert_select "input#achievement_summary[name=?]", "achievement[summary]"
    end
  end
end
