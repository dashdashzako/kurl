class AddColumnsToUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :original, :string
    add_column :urls, :short, :string
    add_column :urls, :expires_at, :datetime

    add_index :urls, :expires_at
  end
end
