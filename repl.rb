# REPL

if ARGV[0] == "help" 
  puts "Here is a list of available commands:"
  puts "  new  - Create a new contact"
  puts "  list - List all contacts"
  puts "  show - Show a contact (eg. 'ruby main.rb show 3')"
  puts "  find_first - Find a contact by FIRST name (eg. 'ruby main.rb findfirst Ben')"
  puts "  find_last - Find a contact by LAST name (eg. 'ruby main.rb findlast Sanders')" # case sensitive
  puts "  find_email - Find a contact by EMAIL (eg. 'ruby main.rb find_email ben@bensanders.ca')" 
  puts "  delete - Delete a contact (eg. 'ruby main.rb delete 3')" 
  puts "  add_phone - Add phone (eg. 'ruby main.rb add_phone 3 Mobile 8673368077')" # TODO BONUS
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

    digit_array = []

    loop do
      puts "Enter phone (##########) - enter 'q' if done" # Error checking later
      phone = STDIN.gets.chomp
      break if phone.to_i <= 0
      puts "Enter lable (eg. 'Mobile')"
      label = STDIN.gets.chomp
      digit_array << { phone: phone, label: label }
    end

    new_contact = Contact.new(firstname, lastname, email)
    new_contact.save
    new_contact.add_phone(digit_array) if digit_array.length > 0
  end
elsif ARGV[0] == "list" 
  array_of_contacts = Contact.all
  array_of_contacts.each do |contact| 
    phone_mash = ""
    contact.phone.each { |phone_hash| phone_mash << " | #{phone_hash[:phone]} (#{phone_hash[:label]})" }
    puts "#{contact.id}: #{contact.lastname}, #{contact.firstname} (#{contact.email})#{phone_mash}"
  end
elsif ARGV[0] == "show" && ARGV[1]
  contact = Contact.find(ARGV[1].to_i) # do I need the '.to_i' ?
  phone_mash = ""
  contact.phone.each { |phone_hash| phone_mash << " | #{phone_hash[:phone]} (#{phone_hash[:label]})" } if contact
  puts contact ? "#{contact.lastname}, #{contact.firstname} (#{contact.email})#{phone_mash}" : "#{ARGV[1]} (not found)"
elsif ARGV[0] == "find_first" && ARGV[1]
  array_of_contacts = Contact.find_all_by_firstname((ARGV[1]))
  array_of_contacts.each do |contact| 
    phone_mash = ""
    contact.phone.each { |phone_hash| phone_mash << " | #{phone_hash[:phone]} (#{phone_hash[:label]})" }
    puts "#{contact.id}: #{contact.lastname}, #{contact.firstname} (#{contact.email})#{phone_mash}"
  end
elsif ARGV[0] == "find_last" && ARGV[1]
  array_of_contacts = Contact.find_all_by_lastname((ARGV[1]))
  array_of_contacts.each do |contact| 
    phone_mash = ""
    contact.phone.each { |phone_hash| phone_mash << " | #{phone_hash[:phone]} (#{phone_hash[:label]})" }
    puts "#{contact.id}: #{contact.lastname}, #{contact.firstname} (#{contact.email})#{phone_mash}"
  end
elsif ARGV[0] == "find_email" && ARGV[1]
  contact = Contact.find_by_email((ARGV[1]))
  phone_mash = ""
  contact.phone.each { |phone_hash| phone_mash << " | #{phone_hash[:phone]} (#{phone_hash[:label]})" }
  puts contact ? "#{contact.id}: #{contact.lastname}, #{contact.firstname} (#{contact.email})#{phone_mash}" : "#{ARGV[1]} (not found)"
elsif ARGV[0] == "delete" && ARGV[1]
  Contact.destroy(ARGV[1].to_i)
  puts "ID-#{ARGV[1].to_i} was deleted..."
elsif ARGV[0] == "add_phone" && ARGV[1] && ARGV[2] && ARGV[3]
  mod_contact = Contact.find(ARGV[1])
  mod_contact.add_phone([{ phone: ARGV[3], label: ARGV[2]}]) if mod_contact # not error checking for order of input
end