class Image < ApplicationRecord
  belongs_to :user

  before_save :upload_image
  attr_accessor :upload

  def get_thumb
    get_image 368, 264
  end

  def get_small_thumb
    get_image 240, 190
  end

  def get_link
    "/uploads/images/original/#{self.file}"
  end

  def get_image(w, h)
    dir = get_upload_dir "#{w}x#{h}"
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    path = "#{dir}/#{self.file}"
    unless File.exist?(path)
      img = Magick::Image.read(get_upload_dir('original', self.file)).first
      img.resize_to_fill!(w, h)
      img.write path
    end
    "/uploads/images/#{w}x#{h}/#{self.file}"
  end

  private

  def get_upload_dir(*dir)
    Rails.root.join('public', 'uploads', 'images', *dir)
  end

  def generate_filename
    file_name = upload.original_filename
    ext_name = File.extname(upload.original_filename).downcase
    rnd = rand(999999)
    time = Time.now.to_i
    "#{user_id}-#{time}-#{file_name}-#{rnd}#{ext_name}"
  end

  def upload_image
    if upload
      dir = get_upload_dir 'original'
      FileUtils.mkdir_p(dir) unless File.directory?(dir)

      self.file = generate_filename

      path = "#{dir}/#{self.file}"

      File.delete(path) if File.exist?(path)

      File.open(path, 'wb') do |f|
        f.write(upload.read)
      end
    end
  end
end
