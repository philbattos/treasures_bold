class ChangeSearchesTableToQueries < ActiveRecord::Migration
  def change
  	rename_table :searches, :queries
  end
end
