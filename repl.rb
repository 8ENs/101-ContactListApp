# REPL

if ARGV[0] == "help" 
  puts "Here is a list of available commands:"
  puts "  new  - Create a new contact"
  puts "  list - List all contacts"
  puts "  show - Show a contact (eg. 'ruby main.rb show 3')"
  puts "  findfirst - Find a contact by FIRST name (eg. 'ruby main.rb findfirst Ben')"
  puts "  findlast - Find a contact by LAST name (eg. 'ruby main.rb findlast Sanders')" # case sensitive
  # puts "  add_phone - Add phone (eg. 'ruby main.rb add_phone Mobile 8673368077')" # TODO BONUS
elsif ARGV[0] == "new" 
  puts "Enter email:"
  email = STDIN.gets.chomp
  if Contact.find_by_email(email)
    puts "Error: that email address already exists!"
  else
    puts "Enter first name:"
    firstname = STDIN.gets.chomp

    puts "Enter last name:"
    lastname = STDIN.gets.chomp

    Contact.new(firstname, lastname, email).save
  end
elsif ARGV[0] == "list" 
  # binding.pry
  array_of_contacts = Contact.all
  array_of_contacts.each { |contact| puts "#{contact.lastname}, #{contact.firstname} (#{contact.email})" }
elsif ARGV[0] == "show" && ARGV[1]
  contact = Contact.find(ARGV[1].to_i)
  puts contact ? "#{contact.lastname}, #{contact.firstname} (#{contact.email})" : "#{ARGV[1]} (not found)"
elsif ARGV[0] == "findfirst" && ARGV[1]
  array_of_contacts = Contact.find_all_by_firstname((ARGV[1]))
  array_of_contacts.each { |contact| puts "#{contact.lastname}, #{contact.firstname} (#{contact.email})" }
elsif ARGV[0] == "findlast" && ARGV[1]
  array_of_contacts = Contact.find_all_by_lastname((ARGV[1]))
  array_of_contacts.each { |contact| puts "#{contact.lastname}, #{contact.firstname} (#{contact.email})" }
end