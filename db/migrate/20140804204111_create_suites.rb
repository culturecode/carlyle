class CreateSuites < ActiveRecord::Migration
  def change
    create_table :suites do |t|
      t.integer :number
      t.timestamps
    end
  end
end
