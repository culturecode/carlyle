class CreateSuitePeople < ActiveRecord::Migration
  def change
    create_table :suite_people do |t|
      t.references :person
      t.references :suite
      t.string :relationship
    end
  end
end
