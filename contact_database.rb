## TODO: Implement CSV reading/writing
require 'csv'

class Contact_Database

  def read_contacts
    contacts = CSV.read('contacts.csv')

    #contacts.each do |contact|
    #  puts "#{contact[0]}: #{contact[1]} (#{contact[2]})"
    #end

    #CSV.foreach('contacts.csv') do |row|
    #  puts "#{contact[0]}: #{contact[1]} (#{contact[2]})"
    #end
  end 

  def write_contact(contact_array)
    #contacts = CSV.read('contacts.csv')
    #id = contacts.length + 1
    CSV.open("contacts.csv", "a") do |content|
      content << contact_array
    end
  end

  # reading & writing contacts.csv
  # how many methods? (instance or class methods?)
  # when should the app write to the file?
  # seed CSV to work off existing contacts
end


=begin
 
CSV.foreach('customers.csv') do |row|
  puts row.inspect
end  

# output: ["Benjamin Sanders", "ben@coderush.ca"]

#CSV.foreach('contacts.csv') do |row|                           # TODO: Not working
  puts row
#end
    .push "#{contact[0]}: #{contact[1]} (#{contact[2]})"

=end