# ruby contact_list.rb show 1
# Here is a list of available commands:
#    new  - Create a new contact
#    list - List all contacts
#    show - Show a contact
#    find - Find a contact

class Contact
 
  attr_accessor :name, :email
 
  def initialize(name, email)
    @name = name
    @email = email
  end
 
  def to_s
    # TODO: return string representation of Contact
  end
 
  ## Class Methods
  class << self #Contact.______  # purpose of this line???
    def create(name, email)
      #contact = Contact.new(name, email) # why?
      
      #contacts = rolodex.read_contacts # eventually move outside of here
      #id = contacts.length + 1
      #new_contact = [id, full_name, email]
      #rolodex.write_contact(new_contact) # TODO rolodex not accessible!
      #puts "#{full_name} has been stored as id #{id}"

      # TODO: Will initialize a contact
      # add it to the list of contacts
    end
 
    def find(search_string)
      #IN: sub-string
      results_array = []

      CSV.foreach('contacts.csv') do |contact|
        if contact[1].downcase.include?(search_string.downcase) || contact[2].downcase.include?(search_string.downcase)
          results_array << contact
        end
      end
      results_array
      #OUT: corresponding contact
    end
 
    def all
      i = 0
      CSV.foreach('contacts.csv') do |contact|
        puts "#{contact[0]}: #{contact[1]} (#{contact[2]})"
        i += 1
      end
      puts "---"
      puts "#{i} record(s) total" # puts "#{contacts.length} record(s) total"
    end
    
    def show(id)
      CSV.foreach('contacts.csv') do |row|
        return row if row[0].to_i == id
      end
      #OUT: corresponding contact
    end

    def print(array_of_contacts)
      array_of_contacts.each { |contact| puts "#{contact[0]}: #{contact[1]} (#{contact[2]})" }
      "(end of list)"
    end
  end
end