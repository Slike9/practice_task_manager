class AddAncestryToStoryComments < ActiveRecord::Migration
  def change
    add_column :story_comments, :ancestry, :string
    add_index :story_comments, :ancestry
  end
end
