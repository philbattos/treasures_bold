require 'spec_helper'

### Model tests should test for:
# -the default factory should generate a valid object
# -data that fail validations should not be valid
# -class and instance methods perform as expected

describe Search do  
	before { @search = FactoryGirl.create :search }

	describe "validations" do
		it { should validate_presence_of :verbatim }
		# it { should validate_presence_of :terms }

	  it "has a valid factory" do
	  	@search.should be_valid
	  	expect(@search).to be_valid
	  end

	  it "is invalid without a :verbatim field" do
	  	@search.verbatim = nil
	  	@search.should_not be_valid
	  	expect(@search).to_not be_valid
	  end

	  it "is invalid without a :terms field" do
	  	pending ":terms field not required"
	  	@search.terms = nil
	  	@search.should_not be_valid
	  	expect(@search).to_not be_valid
	  end

	  it "returns a search with :verbatim and :terms" do
	  	@search.verbatim.should_not be_nil
	  	@search.terms.should_not be_nil
	  end
	end

	describe "database" do
		it "has one search in the database" do
			expect(Search).to have(1).record
			expect(Search.count).to eq 1
		end

		it "correctly adds one record to the database" do
			FactoryGirl.create :search
			expect(Search).to have(2).records
			expect(Search.count).to eq 2
		end

		it "correctly counts records that match a query" do
			search_results = Search.search "Example Search"
			expect(search_results).to have(1).record
			expect(Search.where(terms: ["fake", "search"])).to have(0).records
		end
	end

	describe ":terms" do
		it "is an array" do
			@search.terms.should eq ['Example', 'Search']
			expect(@search.terms).to eq ['Example', 'Search']
		end

		it "parsed version of :verbatim" do
			@search.terms.should eq @search.verbatim.split(" ")
			expect(@search.terms).to eq @search.verbatim.split(" ")
		end
	end

	describe "parse_search_terms method" do
		it "parses :verbatim into separate words" do
			expect(@search.terms).to eq @search.verbatim.split(" ")
		end

		it "stores parsed words in :terms field" do
			expect(@search.terms).to eq Search.find(@search.id)[:terms]
		end
	end
end
