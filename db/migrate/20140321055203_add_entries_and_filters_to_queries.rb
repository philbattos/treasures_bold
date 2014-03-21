class AddEntriesAndFiltersToQueries < ActiveRecord::Migration
  def change
  	add_column :queries, :entries, :string
  	add_column :queries, :filters, :string 
  end
end
