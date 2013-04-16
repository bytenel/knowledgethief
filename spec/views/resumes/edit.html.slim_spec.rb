require 'spec_helper'

describe "resumes/edit" do
  before(:each) do
    @resume = assign(:resume, stub_model(Resume,
      :user_id => 1,
      :phone => "MyString",
      :address => "MyString",
      :summary => "MyString"
    ))
  end

  it "renders the edit resume form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", resume_path(@resume), "post" do
      assert_select "input#resume_user_id[name=?]", "resume[user_id]"
      assert_select "input#resume_phone[name=?]", "resume[phone]"
      assert_select "input#resume_address[name=?]", "resume[address]"
      assert_select "input#resume_summary[name=?]", "resume[summary]"
    end
  end
end
