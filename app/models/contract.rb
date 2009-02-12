class Contract < ActiveRecord::Base
  belongs_to :contract_category
  belongs_to :contract_type
  
  def saveFiles(files)
    files.each do |file|
      debugger
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
    debugger
    name =  file.original_filename
    directory = "#{CONTRACT_FILE_PATH}/contract/#{self.id}"
    # create the file path
    FileUtils.mkdir(directory) unless File.exists?(directory) 
    path = File.join(directory, name)
    
    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }
  end
  
  def destroyFile
    debugger
    directory = "#{CONTRACT_FILE_PATH}/contract/#{self.id}"
    #FileUtils.rmdir(directory)
    FileUtils.rm_r directory, :force => true
  end
end
