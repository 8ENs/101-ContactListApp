require_relative 'contact_database'
require_relative 'contact'

# NOTE: currently depending on row # in .csv as the ID, but that will fall apart if ever we introduced a DELETE method/command

Contact.init("contacts.csv")

if ARGV[0] == "help" 
  puts "Here is a list of available commands:"
  puts "  new  - Create a new contact"
  puts "  list - List all contacts"
  puts "  show - Show a contact (eg. 'ruby contact_list.rb show 3'"
  puts "  find - Find a contact (eg. 'ruby contact_list.rb find ben'"
  puts "  add_phone - Add phone (eg. 'ruby contact_list.rb add_phone Mobile 8673368077'" # TODO BONUS
elsif ARGV[0] == "new" 
  puts "Enter email:"
  email = STDIN.gets.chomp
  if Contact.find(email) == []
    puts "Enter full name:"
    name = STDIN.gets.chomp
    digit_array = []

    loop do
      puts "Enter phone (##########) - enter 'q' if done" # Error checking later
      phone = STDIN.gets.chomp
      break if phone.to_i <= 0
      puts "Enter lable (eg. 'Mobile')"
      label = STDIN.gets.chomp
      digit_array << "#{label}: #{phone}"
    end
    Contact.create(name, email, digit_array)
  else
    puts "Error: that email address already exists!"
  end
elsif ARGV[0] == "list" 
  Contact.all
elsif ARGV[0] == "show" && ARGV[1]
  contact = Contact.show(ARGV[1].to_i)
  puts contact ? contact : "#{ARGV[1]} (not found)"
elsif ARGV[0] == "find" && ARGV[1]
  contact = Contact.find(ARGV[1])
  puts contact ? Contact.print(contact) : "#{ARGV[1]} (not found)"
elsif ARGV[0] == "add_phone" #&& ARGV[1] # TODO BONUS
  rolodex.add_phone(99, "Monica", "monica@lighthouselabs.ca")
end

# Driver code