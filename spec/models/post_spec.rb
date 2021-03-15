require 'rails_helper'

RSpec.describe Post, :type => :model do
  before do
    @user = create(:user, email: 'gmail@gmail.com', password: "password")
  end

  subject {
    described_class.new(title: "Anything",
                        body: "Lorem ipsum",
                        category: "sport",
                        user_id: @user.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it "is not valid when title > 1000" do
    subject.title = 'd' * 1000
    expect(subject).to_not be_valid
  end

  it "has many comments" do
    should respond_to(:comments)
  end

  it { is_expected.to belong_to(:user) }
end