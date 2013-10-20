class ChangeTableNameFromMiningsToSearch < ActiveRecord::Migration
  def change
  	rename_table :minings, :search
  end
end
