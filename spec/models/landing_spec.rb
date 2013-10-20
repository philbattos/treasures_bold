require 'spec_helper'

### Model tests should test for:
# -the default factory should generate a valid object
# -data that fail validations should not be valid
# -class and instance methods perform as expected

describe Landing do  
	before do
		@landing = FactoryGirl.create :landing
	end

	describe "validations" do
		it { should validate_presence_of :feature_name }
		it { should validate_presence_of :feature_class }

	  it "has a valid factory" do
	  	@landing.should be_valid
	  	expect(@landing).to be_valid
	  end

	  it "is invalid without a feature_name" do
	  	@landing.feature_name = nil
	  	@landing.should_not be_valid
	  	expect(@landing).to_not be_valid
	  end

	  it "is invalid without a feature_class" do
	  	@landing.feature_class = nil
	  	@landing.should_not be_valid
	  	expect(@landing).to_not be_valid
	  end

	  it "returns a landing with a feature_name and feature_class" do
	  	@landing.feature_name.should_not be_nil
	  	@landing.feature_class.should_not be_nil
	  end
	end

	describe "database" do
		it "has one landing in the database" do
			expect(Landing).to have(1).record
			expect(Landing.count).to eq 1
		end

		it "correctly adds one record to the database" do
			FactoryGirl.create :landing
			expect(Landing).to have(2).records
			expect(Landing.count).to eq 2
			Landing.delete_all
		end

		it "correctly counts records that match a query" do
			search_results = Landing.search "Example Landing"
			expect(search_results).to have(1).record
			expect(Landing.where(feature_class: "fake class")).to have(0).records
		end
	end
end
