require 'spec_helper'

describe "educations/edit" do
  before(:each) do
    @education = assign(:education, stub_model(Education,
      :resume_id => 1,
      :city => "MyString",
      :state => "MyString",
      :user_id => 1,
      :school_name => "MyString",
      :major => "MyString",
      :since_year => "MyString",
      :end_year => "MyString"
    ))
  end

  it "renders the edit education form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", education_path(@education), "post" do
      assert_select "input#education_resume_id[name=?]", "education[resume_id]"
      assert_select "input#education_city[name=?]", "education[city]"
      assert_select "input#education_state[name=?]", "education[state]"
      assert_select "input#education_user_id[name=?]", "education[user_id]"
      assert_select "input#education_school_name[name=?]", "education[school_name]"
      assert_select "input#education_major[name=?]", "education[major]"
      assert_select "input#education_since_year[name=?]", "education[since_year]"
      assert_select "input#education_end_year[name=?]", "education[end_year]"
    end
  end
end
