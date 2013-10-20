class ChangeSearchTableToSearches < ActiveRecord::Migration
  def change
  	rename_table :search, :searches
  end
end
