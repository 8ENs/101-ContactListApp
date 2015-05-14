# REPL

if ARGV[0] == "help" 
  puts "Here is a list of available commands:"
  puts "  new        - Create new contact"
  puts "  list       - List all contacts"
  puts "  find       - Find contact (eg. 'ruby setup.rb find 3')"
  puts "  find_first - Find contact by FIRST name (eg. 'ruby setup.rb findfirst Ben')"
  puts "  find_last  - Find contact by LAST name (eg. 'ruby setup.rb findlast Sanders')" # case sensitive
  puts "  find_email - Find contact by EMAIL (eg. 'ruby setup.rb find_email ben@bensanders.ca')" 
  puts "  delete     - Delete contact (eg. 'ruby setup.rb delete 3')" 
  puts "  add_phone  - Add phone (eg. 'ruby setup.rb add_phone 3 Mobile 8673368077')"
elsif ARGV[0] == "new" 
  puts "Enter email:"
  email_in = STDIN.gets.chomp
  if Contact.where(email: email_in).length > 0
    puts "Error: that email address already exists!"
  else
    puts "Enter first name:"
    firstname_in = STDIN.gets.chomp

    puts "Enter last name:"
    lastname_in = STDIN.gets.chomp

    digit_array = []
    loop do
      puts "Enter phone (##########) - enter 'q' if done" # Error checking later
      phone_in = STDIN.gets.chomp
      break if phone_in.to_i <= 0
      puts "Enter label (eg. 'Mobile')"
      label_in = STDIN.gets.chomp
      digit_array << { phone: phone_in, label: label_in }
    end

    new_contact = Contact.create(firstname: firstname_in, lastname: lastname_in, email: email_in)
    digit_array.each { |phone_hash| Phone.create(phone: phone_hash[:phone], label: phone_hash[:label], contact_id: new_contact.id) } if digit_array.length > 0
  end

elsif ARGV[0] == "list" 
  puts Contact.all ? Contact.all : "(DB empty)"
  
elsif ARGV[0] == "find" && ARGV[1]
  # need error/exception handling when id doesn't exist
  puts Contact.find(ARGV[1])

elsif ARGV[0] == "find_first" && ARGV[1]
  puts Contact.where(firstname: ARGV[1]).length > 0 ? Contact.where(firstname: ARGV[1]) : "#{ARGV[1]} (first name not found)"

elsif ARGV[0] == "find_last" && ARGV[1]
  puts Contact.where(lastname: ARGV[1]).length > 0 ? Contact.where(lastname: ARGV[1]) : "#{ARGV[1]} (last name not found)"

elsif ARGV[0] == "find_email" && ARGV[1]
  puts Contact.where(email: ARGV[1]).length > 0 ? Contact.where(email: ARGV[1]) : "#{ARGV[1]} (email not found)"

elsif ARGV[0] == "delete" && ARGV[1]
  # need error/exception handling when id doesn't exist
  Contact.find(ARGV[1]).destroy
  Phone.find_by(contact_id: ARGV[1]).destroy

  # currently will puts this message whether ARGV[1] exists or not
  puts "ID-#{ARGV[1]} was deleted..."

elsif ARGV[0] == "add_phone" && ARGV[1] && ARGV[2] && ARGV[3]
  # not error checking for order of inputs (ARGV's) or if that # already exists
  Phone.create(phone: ARGV[3], label: ARGV[2], contact_id: ARGV[1])
end