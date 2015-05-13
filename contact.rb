class Contact
  attr_accessor :firstname, :lastname, :email, :id # all needed as accessor?
 
  @@connection = nil # should there still be a class variable?
  
  def self.connection
    # if nil, create; else return existing
    if @@connection.nil?
      @@connection = PG::Connection.new( :host => ENV["HOST"], :dbname => ENV["DB"], :user => ENV["DBUSER"], :password => ENV["PASS"], :port => ENV["PORT"] )
    end
    @@connection
    # returns connection object
  end 

  CONN = Contact.connection

  def initialize(firstname, lastname, email, id = nil)
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = id
  end
 
  # def to_s(contact_array) # could remove argument but would need to adjust ContactDatabase.read_contacts to return Contact objects
  #   # TODO: return string representation of Contact
  #   "#{contact_array[0]}: #{contact_array[1]} (#{contact_array[2]}) #{contact[3]}"
  # end

  def is_new?
    @id.nil?
  end

  def save
    if is_new?
      result = CONN.exec_params('INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) returning id;', [@firstname, @lastname, @email])
      @id = result[0]['id']
    else
      CONN.exec_params('UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id = $4;', [@firstname, @lastname, @email, @id])
    end
  end

  def destroy
    CONN.exec_params('DELETE FROM contacts WHERE id = $1', [@id])
  end

  def self.find(id)
    con_obj = CONN.exec_params('SELECT * FROM contacts WHERE id = $1 LIMIT 1;', [id])
    if con_obj.ntuples > 0
      result = Contact.new(con_obj[0]['firstname'], con_obj[0]['lastname'], con_obj[0]['email'], id)
    end

    # return single Contact or NIL
  end
 
  def self.all
    results = []
    CONN.exec_params('SELECT * FROM contacts;').each do |tuple|
      results << Contact.new(
        tuple['firstname'],
        tuple['lastname'],
        tuple['email'],
        tuple['id']
      )
    end
    results # return array of Contacts (or nil)
  end
 
  def self.find_all_by_lastname(lastname)
    results = []
    CONN.exec_params('SELECT * FROM contacts WHERE lastname = $1', [lastname]).each do |tuple|
      results << Contact.new(
        tuple['firstname'],
        lastname,
        tuple['email'],
        tuple['id']
      )
    end
    results # return array of Contacts (or nil)
  end

  def self.find_all_by_firstname(firstname)
    results = []
    CONN.exec_params('SELECT * FROM contacts WHERE firstname = $1', [firstname]).each do |tuple|
      results << Contact.new(
        firstname,
        tuple['lastname'],
        tuple['email'],
        tuple['id']
      )
    end
    results # return array of Contacts (or nil)
  end

  def self.find_by_email(email)
    con_obj = CONN.exec_params('SELECT * FROM contacts WHERE email = $1 LIMIT 1;', [email])
    if con_obj.ntuples > 0
      result = Contact.new(con_obj[0]['firstname'], con_obj[0]['lastname'], email, con_obj[0]['id'])
    end
    # return either single contact (or nil)
  end
end