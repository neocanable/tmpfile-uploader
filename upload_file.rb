class UploadFile
  attr_reader :original_filename, :dir, :name, :extension, :tempfile
	
	class << self
		def upload(tmp_file)
			file = new(tmp_file)
			file.save
		end
	end

  def initialize(tempfile, options = {})
    raise "FileNotFound" unless tempfile
    @tempfile          = tempfile
    @original_filename = tempfile.original_filename
    @dir               = options[:namespace] || "upload_files"
		
		@name              = SecureRandom.hex(16)
		@extension         = File.extname(tmpfile)

		@store_dir         = Time.now.strftime('%Y-%m-%d')
  end

  def path
    @tempfile.path
  end

	def generated_filename
		"#{@name}.#{@extension}"
	end

	# write file
  def save
    @tempfile.close
    FileUtils.mkdir_p(file_dir)
    FileUtils.mv(@tempfile.path, generate_file_path)
    path = FileUtils.chmod(0644, generate_file_path).first

    #system("convert -resize x300 -resize '300x<' -resize 300  #{path} #{path}")
    url
  end

  def url
		File.join(@dir, @store_dir, generated_filename)
  end

  def file_dir
		File.join(Rails.public_path, @dir, @store_dir)
  end

  def generate_file_path
		File.join(file_dir, generated_filename)
  end

end
