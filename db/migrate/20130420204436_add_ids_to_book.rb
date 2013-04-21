class AddIdsToBook < ActiveRecord::Migration
  def change
    add_column :books, :word_id, :integer
    add_column :books, :gr_id, :integer
  end
end
