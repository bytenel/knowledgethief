require 'spec_helper'

describe "achievements/new" do
  before(:each) do
    assign(:achievement, stub_model(Achievement,
      :summary => "MyString"
    ).as_new_record)
  end

  it "renders new achievement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", achievements_path, "post" do
      assert_select "input#achievement_summary[name=?]", "achievement[summary]"
    end
  end
end
