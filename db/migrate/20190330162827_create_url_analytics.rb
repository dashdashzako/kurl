class CreateUrlAnalytics < ActiveRecord::Migration[5.2]
  def change
    create_table :url_analytics do |t|
      t.references :url, foreign_key: true

      t.timestamps
    end
  end
end
