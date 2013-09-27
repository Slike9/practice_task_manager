class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.references :author, index: true
      t.references :owner, index: true

      t.timestamps
    end
  end
end
