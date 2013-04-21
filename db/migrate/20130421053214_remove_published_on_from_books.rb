class RemovePublishedOnFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :published_on
  end

  def down
    add_column :books, :published_on
  end
end
