class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.string :content_type
      t.binary :data, limit: 1.megabyte

      t.timestamps null: false
    end
  end
end
