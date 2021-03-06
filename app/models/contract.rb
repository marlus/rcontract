class Contract < ActiveRecord::Base
  belongs_to :contract_category
  belongs_to :contract_type
  has_many :alarms
  
  def saveFiles(files)
    files.each do |file|
      name =  file.original_filename
      directory = "#{CONTRACT_FILE_PATH}/contract/#{self.id}"
      # create the file path
      FileUtils.mkdir(directory) unless File.exists?(directory) 
      path = File.join(directory, name)
    
      # write the file
      File.open(path, "wb") { |f| f.write(file.read) }
    end
  end
  
  def saveFile(file)
    name =  file.original_filename
    directory = "#{CONTRACT_FILE_PATH}/contract/#{self.id}"
    # create the file path
    FileUtils.mkdir(directory) unless File.exists?(directory) 
    path = File.join(directory, name)
    
    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }
  end
  
  def destroyFile
    directory = "#{CONTRACT_FILE_PATH}/contract/#{self.id}"
    #FileUtils.rmdir(directory)
    FileUtils.rm_r directory, :force => true
  end
  def destroyUniqueFile
    file = "#{CONTRACT_FILE_PATH}/contract/#{self.id}/#{self.file}"
    #FileUtils.rmdir(directory)
    FileUtils.remove_file file, :force => true
  end
end
