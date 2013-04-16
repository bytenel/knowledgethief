require 'spec_helper'

describe "resumes/new" do
  before(:each) do
    assign(:resume, stub_model(Resume,
      :user_id => 1,
      :phone => "MyString",
      :address => "MyString",
      :summary => "MyString"
    ).as_new_record)
  end

  it "renders new resume form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", resumes_path, "post" do
      assert_select "input#resume_user_id[name=?]", "resume[user_id]"
      assert_select "input#resume_phone[name=?]", "resume[phone]"
      assert_select "input#resume_address[name=?]", "resume[address]"
      assert_select "input#resume_summary[name=?]", "resume[summary]"
    end
  end
end
