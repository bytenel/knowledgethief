require 'spec_helper'

describe "skills/edit" do
  before(:each) do
    @skill = assign(:skill, stub_model(Skill,
      :resume_id => 1,
      :user_id => 1,
      :name => "MyString",
      :summary => "MyString"
    ))
  end

  it "renders the edit skill form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", skill_path(@skill), "post" do
      assert_select "input#skill_resume_id[name=?]", "skill[resume_id]"
      assert_select "input#skill_user_id[name=?]", "skill[user_id]"
      assert_select "input#skill_name[name=?]", "skill[name]"
      assert_select "input#skill_summary[name=?]", "skill[summary]"
    end
  end
end
