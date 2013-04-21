class RenameWorkIdInBook < ActiveRecord::Migration

  def change
    rename_column :books, :word_id, :work_id
  end

  def up
  end

  def down
  end
end
