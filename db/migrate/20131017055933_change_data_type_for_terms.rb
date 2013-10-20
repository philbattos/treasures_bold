class ChangeDataTypeForTerms < ActiveRecord::Migration
  def change
  	change_column :minings, :terms, :text
  end
end
