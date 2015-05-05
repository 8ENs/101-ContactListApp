require_relative 'contact_database'

contacts = [] # Array.new

rolodex = Contact_Database.new

require_relative 'contact'

if ARGV[0] == "help" 
  puts "Here is a list of available commands:"
  puts "  new  - Create a new contact"
  puts "  list - List all contacts"
  puts "  show - Show a contact"
  puts "  find - Find a contact"
elsif ARGV[0] == "new" 
  # TODO: why STDIN? (http://stackoverflow.com/questions/27453569/using-gets-gives-no-such-file-or-directory-error-when-i-pass-arguments-to-my)
  puts "Enter email:"
  email = STDIN.gets.chomp
  if Contact.find(email) == []
    puts "Enter full name:"
    full_name = STDIN.gets.chomp
    #Contact.create(full_name, email)
    contacts = rolodex.read_contacts # eventually move outside of here
    id = contacts.length + 1
    new_contact = [id, full_name, email]

    rolodex.write_contact(new_contact)
    
    #contacts << new_contact
    puts "#{full_name} has been stored as id #{id}"
  else
    puts "Error: that email address already exists!"
  end
elsif ARGV[0] == "list" 
  Contact.all # TODO move stuff into contact.rb
  
elsif ARGV[0] == "show" && ARGV[1]
  contact = Contact.show(ARGV[1].to_i)
  puts contact ? contact : "#{ARGV[1]} (not found)"
elsif ARGV[0] == "find" && ARGV[1]
  contact = Contact.find(ARGV[1])

  puts contact ? Contact.print(contact) : "#{ARGV[1]} (not found)"
  # search names of contact & print details of *any* which have search term contained in name *or* email
  # eg: ruby contact_list.rb find ted
end

# Driver code

#rolodex.read_contacts

#Contact.create("Keran Sanders", "k2p2@mts.net")
#rolodex.read_contacts