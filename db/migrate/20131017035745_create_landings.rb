class CreateLandings < ActiveRecord::Migration
  def change
    create_table :landings do |t|
      t.integer :feature_id
      t.string :feature_name
      t.string :feature_class

      t.timestamps
    end
  end
end
