require 'spec_helper'

### Model tests should test for:
# -the default factory should generate a valid object
# -data that fail validations should not be valid
# -class and instance methods perform as expected

describe Query do  
	before { @query = FactoryGirl.create :query }

	describe "validations" do
		it { should validate_presence_of :verbatim }
		# it { should validate_presence_of :terms }

	  it "has a valid factory" do
	  	@query.should be_valid
	  	expect(@query).to be_valid
	  end

	  it "is invalid without a :verbatim field" do
	  	@query.verbatim = nil
	  	@query.should_not be_valid
	  	expect(@query).to_not be_valid
	  end

	  it "is invalid without a :terms field" do
	  	pending ":terms field not required"
	  	@query.terms = nil
	  	@query.should_not be_valid
	  	expect(@query).to_not be_valid
	  end

	  it "returns a search with :verbatim and :terms" do
	  	@query.verbatim.should_not be_nil
	  	@query.terms.should_not be_nil
	  end
	end

	describe "database" do
		it "has one search in the database" do
			expect(Query).to have(1).record
			expect(Query.count).to eq 1
		end

		it "correctly adds one record to the database" do
			FactoryGirl.create :query
			expect(Query).to have(2).records
			expect(Query.count).to eq 2
		end

		it "correctly counts records that match a query" do
			search_results = Query.search "Example Query"
			expect(search_results).to have(1).record
			expect(Query.where(terms: ["fake", "search"])).to have(0).records
		end
	end

	describe ":terms" do
		it "is an array" do
			@query.terms.should eq ['Example', 'Search']
			expect(@query.terms).to eq ['Example', 'Search']
		end

		it "parsed version of :verbatim" do
			@query.terms.should eq @query.verbatim.split(" ")
			expect(@query.terms).to eq @query.verbatim.split(" ")
		end
	end

	describe "parse_search_terms method" do
		it "parses :verbatim into separate words" do
			expect(@query.terms).to eq @query.verbatim.split(" ")
		end

		it "stores parsed words in :terms field" do
			expect(@query.terms).to eq Query.find(@query.id)[:terms]
		end
	end
end
