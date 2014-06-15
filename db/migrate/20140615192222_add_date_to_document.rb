class AddDateToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :date, :date

    add_index :documents, :date
  end
end
