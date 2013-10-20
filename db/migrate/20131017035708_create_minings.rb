class CreateMinings < ActiveRecord::Migration
  def change
    create_table :minings do |t|
      t.string :verbatim
      t.string :terms

      t.timestamps
    end
  end
end
