class Search < ActiveRecord::Base
	include Tire::Model::Search
	include Tire::Model::Callbacks

	serialize :terms # this enables :terms to save arrays

	validates :verbatim, presence: true
	# validates :terms, presence: true

	belongs_to :user

	before_save :parse_search_terms

	def parse_search_terms
		self[:terms] = verbatim.split(" ")
	end
end
