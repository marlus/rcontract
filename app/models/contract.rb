class Contract < ActiveRecord::Base
  belongs_to :contract_category
  belongs_to :contract_type
  
  def saveFile(file)
    name =  file.original_filename
    directory = "#{CONTRACT_FILE_PATH}/contract/#{self.id}"

    debugger

    # create the file path
    FileUtils.mkdir(directory) unless File.exists?(directory) 
    path = File.join(directory, name)
    
    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }
  end
end
