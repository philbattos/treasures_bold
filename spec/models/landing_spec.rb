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
		it { should validate_presence_of :feature_id }
		# it { should validate_presence_of :feature_name }
		it { should validate_presence_of :lat_decimal }
		it { should validate_presence_of :long_decimal }

	  it "has a valid factory" do
	  	@landing.should be_valid
	  	expect(@landing).to be_valid
	  end

	  it "is invalid without a feature_id" do
	  	@landing.feature_id = nil
	  	@landing.should_not be_valid
	  	expect(@landing).to_not be_valid
	  end

	  it "is invalid without a feature_name" do
	  	pending "validation turned off"
	  	@landing.feature_name = nil
	  	@landing.should_not be_valid
	  	expect(@landing).to_not be_valid
	  end

	  it "is invalid without lat_decimal coordinates" do
	  	@landing.lat_decimal = nil
	  	@landing.should_not be_valid
	  	expect(@landing).to_not be_valid
	  end

	  it "is invalid without long_decimal coordinates" do
	  	@landing.long_decimal = nil
	  	@landing.should_not be_valid
	  	expect(@landing).to_not be_valid
	  end

	  it "returns a landing with a feature_id, feature_name, lat_decimal, and long_decimal" do
	  	@landing.feature_id.should_not be_nil
	  	# @landing.feature_name.should_not be_nil
	  	@landing.lat_decimal.should_not be_nil
	  	@landing.long_decimal.should_not be_nil
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
		end
	end

	describe "search" do
		it "correctly finds records that match search query based on feature_name" do
			search_results = Landing.search({ fields: { county: 1, feature_class: 1, feature_name: 1, state: 1 }, keyword: "hijklm" })
			expect(search_results.first.feature_name).to eq "abcdefg hijklm nopq"
		end

		it "correctly finds records that match search query based on feature_class" do
			search_results = Landing.search "zyxwv"
			expect(search_results.first.feature_name).to eq "abcdefg hijklm nopq"
		end

		it "correctly counts records that match a query" do
			search_results = Landing.search "abcdefg"
			expect(search_results).to have(1).record
			expect(Landing.where(feature_class: "fake class")).to have(0).records
		end
	end

	describe "compile_search_data" do
		it "parses search query" do

		end

		it "adds a different colored marker for each search term" do

		end

		it "compiles search terms and their markers into an hash" do

		end

		it "creates a hash in the form of { search_term: { landings: [Tire results], marker: link_to_marker }}" do

		end
	end
end
