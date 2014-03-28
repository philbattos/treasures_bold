class CreateRemarks < ActiveRecord::Migration
  def change
    create_table :remarks do |t|
      t.string :name
      t.string :email, null: false
      t.text :message

      t.timestamps
    end
  end
end
