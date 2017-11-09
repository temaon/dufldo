class AddIsCommentableFieldToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :is_commentable, :boolean, default: true
    add_column :posts, :short_description, :string
  end
end
