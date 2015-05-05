## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase # Accessor
  def initialize(file_name)
    @file_name = file_name
  end

  def read_contacts
    CSV.read(@file_name)
  end 

  def write_contact(name, email, phone)
    id = CSV.read(@file_name).length + 1
    CSV.open(@file_name, "a") do |content|
      content << [id, name, email, phone]
    end
    id
  end

  def num_contacts
    CSV.read(@file_name).length # not used currently
  end

  # reading & writing contacts.csv
  # how many methods? (instance or class methods?)
  # when should the app write to the file?
  # seed CSV to work off existing contacts
end