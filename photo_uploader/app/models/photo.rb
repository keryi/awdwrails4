class Photo < ActiveRecord::Base
  validates_format_of :content_type,
    with: /\Aimage/,
    message: 'Must be a picture'

  def uploaded_file=(photo_field)
    self.content_type = photo_field.content_type.chomp
    self.data = photo_field.read
  end
end
