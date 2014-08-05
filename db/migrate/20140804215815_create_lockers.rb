class CreateLockers < ActiveRecord::Migration
  def change
    create_table :lockers do |t|
      t.integer :number
      t.string :location
      t.text :description

      t.references :suite

      t.timestamps
    end
  end
end
