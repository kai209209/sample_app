class Picture < ActiveRecord::Base
  mount_uploader :name, PictureUploader
  belongs_to :user
  validates :name, presence: true
  before_save :update_picture_attributes

  private
    def update_picture_attributes
    	if name.present? && name_changed?
          self.name = name.file.original_filename
          self.content_type = name.file.content_type
          # self.file_size = name.file_size
    	end
    end



end
