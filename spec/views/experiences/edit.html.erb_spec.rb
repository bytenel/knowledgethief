require 'spec_helper'

describe "experiences/edit" do
  before(:each) do
    @experience = assign(:experience, stub_model(Experience,
      :resume_id => 1,
      :user_id => 1,
      :institute_name => "MyString",
      :city => "MyString",
      :state => "MyString",
      :since_year => "MyString",
      :end_year => "MyString",
      :title => "MyString",
      :summary => "MyString"
    ))
  end

  it "renders the edit experience form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", experience_path(@experience), "post" do
      assert_select "input#experience_resume_id[name=?]", "experience[resume_id]"
      assert_select "input#experience_user_id[name=?]", "experience[user_id]"
      assert_select "input#experience_institute_name[name=?]", "experience[institute_name]"
      assert_select "input#experience_city[name=?]", "experience[city]"
      assert_select "input#experience_state[name=?]", "experience[state]"
      assert_select "input#experience_since_year[name=?]", "experience[since_year]"
      assert_select "input#experience_end_year[name=?]", "experience[end_year]"
      assert_select "input#experience_title[name=?]", "experience[title]"
      assert_select "input#experience_summary[name=?]", "experience[summary]"
    end
  end
end
