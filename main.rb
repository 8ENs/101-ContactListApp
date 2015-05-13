require 'pry'
require 'dotenv'
Dotenv.load
require 'pg'

require_relative 'contact'
require_relative 'repl'

# Driver code

# contact = Contact.new("Khurram", "Virani", "k@gmail.com")
# contact.save

# contact.firstname = "K"
# contact.lastname = "V"
# contact.save

# same_contact = Contact.find(5)
# puts same_contact.firstname # => 'K'
# puts same_contact.lastname  # => 'V'
# puts same_contact.email # => 'kv@gmail.com'

# contacts = Contact.find_all_by_lastname('V')
# contacts.each do |c|
#   puts "#{c.lastname}, #{c.firstname} (#{c.email})"
# end

# same_contact.destroy

# Contact.find(17) # => nil

#############################

# conn = Contact.connection
# result = conn.exec('SELECT * FROM contacts;')
# puts result[0]

# jim = Contact.new('Keran', 'Sanders', 'k2p2@mts.net')
# jim.save
# jim.firstname = 'Jim'
# jim.save

# jim = Contact.new('first', 'last', 'email', 15)
# jim.destroy

# cont = Contact.find(2)
# puts cont.email

# puts "*****"

# contall = Contact.all
# binding.pry
# puts contall

# array = Contact.find_all_by_lastname('Sanders')
# array.each { |contact| puts contact.firstname }

# puts Contact.find_by_email('k2p2@mts.net').firstname
