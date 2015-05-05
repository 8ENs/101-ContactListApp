# ruby contact_list.rb show 1
# Here is a list of available commands:
#    new  - Create a new contact
#    list - List all contacts
#    show - Show a contact
#    find - Find a contact

class Contact
  attr_accessor :name, :email # need full accessor?
 
  def initialize(name, email, phone = [])
    @name = name
    @email = email
    @phone = phone
  end
 
  def to_s(contact_array) # could remove argument but would need to adjust ContactDatabase.read_contacts to return Contact objects
    # TODO: return string representation of Contact
    "#{contact_array[0]}: #{contact_array[1]} (#{contact_array[2]}) #{contact[3]}"
  end
 
  ## Class Methods
  class << self #Contact.______  # purpose of this line???
    def init(file_name)
      @@access_rolodex = ContactDatabase.new(file_name) 
    end

    def print(array_of_contacts)
      array_of_contacts.each { |contact| puts "#{contact[0]}: #{contact[1]} (#{contact[2]}) #{contact[3]}" } # refactor: Contact.to_s(contact) }
      "(end of list)"  # why necessary; return something else?
    end

    def create(name, email, phone_array)
      phone = phone_array.join(" | ")
      Contact.new(name, email, phone)
      id = @@access_rolodex.write_contact(name, email, phone) 
      puts "#{name} has been stored as id #{id}"
    end
 
    def find(search_string)
      #IN: sub-string
      results_array = []

      contacts = @@access_rolodex.read_contacts
      contacts.each do |contact|
        if contact[1].downcase.include?(search_string.downcase) || contact[2].downcase.include?(search_string.downcase)
          results_array << contact
        end
      end
      results_array
      #OUT: corresponding contact
    end

    def add_phone(id, label, number)
      CSV.foreach('contacts.csv') do |contact|
        if contact[0].to_i == id
          contact << "#{label}: #{number}" # format number w/ REGEX down to \d ?
        end
      end
      results_array # return corresponding contact
    end
 
    def all
      i = 0
      array_of_contacts = @@access_rolodex.read_contacts
      array_of_contacts.each do |contact|
        puts "#{contact[0]}: #{contact[1]} (#{contact[2]}) #{contact[3]}" # refactor: Contact.to_s(contact)
        i += 1
      end
      puts "---"
      puts "#{i} record(s) total"
    end
    
    def show(id)
      contacts = @@access_rolodex.read_contacts
      contacts.each do |contact|
        return contact if contact[0].to_i == id
      end
    end
  end
end