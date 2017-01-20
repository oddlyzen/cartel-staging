class AddAttachmentUrlToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :attachment_url, :string
  end
end
