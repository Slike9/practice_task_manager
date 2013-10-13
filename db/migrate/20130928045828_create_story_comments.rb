class CreateStoryComments < ActiveRecord::Migration
  def change
    create_table :story_comments do |t|
      t.text :body
      t.references :author, index: true
      t.references :story, index: true

      t.timestamps
    end
  end
end
