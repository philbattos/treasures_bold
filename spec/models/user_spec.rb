require 'spec_helper'

describe User do
	before { @user = FactoryGirl.create :user }

  describe "validations" do
  	it { should validate_presence_of :username }
  	it { should validate_presence_of :email }

  	it "has a valid factory" do
  		@user.should be_valid
  		expect(@user).to be_valid
  	end

  	it "is invalid without a :username field" do
  		@user.username = nil
  		@user.should_not be_valid
  		expect(@user).to_not be_valid
  	end

  	it "is invalid without a :email field" do
  		@user.email = nil
  		@user.should_not be_valid
  		expect(@user).to_not be_valid
  	end

  	it "returns a user with :username and :email" do
  		@user.username.should_not be_nil
  		@user.email.should_not be_nil
  	end
  end

  describe "database" do
    it "has one user in the database" do
      expect(User).to have(1).record
      expect(User.count).to eq 1
    end

    it "correctly adds one record to the database" do
      FactoryGirl.create :user
      expect(User).to have(2).records
      expect(User.count).to eq 2
    end

    it "correctly counts records that match a query" do
      search_results = User.search "Example Name"
      expect(search_results.size).to eq 1
      expect(User.where(email: "fake_email@example.com")).to have(0).records
    end
  end
end
