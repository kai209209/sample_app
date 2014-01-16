class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :content_type
      t.integer :file_size
  	  t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
