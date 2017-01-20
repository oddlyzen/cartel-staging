class AddAttachmentUrlToBibliographies < ActiveRecord::Migration
  def change
    add_column :bibliographies, :attachment_url, :string
  end
end
