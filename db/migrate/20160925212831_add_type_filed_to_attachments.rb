class AddTypeFiledToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :type, :string, limit: 100
  end
end
