class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.string :isbn
      t.string :cover_url
      t.date :published_on

      t.timestamps
    end
  end
end
