class AddNameAndDescriptionToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :name, :string
    add_column :documents, :description, :text
  end
end
