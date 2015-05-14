class Contact
  attr_accessor :firstname, :lastname, :email, :id, :phone # all needed as accessor?
 
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

  def initialize(firstname, lastname, email, id = nil, phone = [])
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = id
    @phone = phone
  end
 
  def to_s
    "#{@id}: #{@lastname}, #{@firstname} (#{@email})#{self.phone_mash}"
  end

  def phone_mash
    phone_mash = ""
    @phone.each { |phone_hash| phone_mash << " | #{phone_hash[:phone]} (#{phone_hash[:label]})" }
    phone_mash
  end

  def is_new?
    @id.nil?
  end

  def save
    if is_new?
      result = CONN.exec_params('INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) returning id;', [@firstname, @lastname, @email])
      @id = result[0]['id'] # will return @id as String
    else
      CONN.exec_params('UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id = $4;', [@firstname, @lastname, @email, @id])
    end
  end

  def add_phone(digit_array_of_hash)
    # COME BACK AND CHECK IF UPDATING (now only add)
    digit_array_of_hash.each do |phone_label|
      CONN.exec_params('INSERT INTO phones (phone, label, contact_id) VALUES ($1, $2, $3);', [phone_label[:phone], phone_label[:label], @id])
    end
  end

  def get_phones
    sql_string = "SELECT * FROM phones WHERE contact_id = #{@id};"
    numbers = CONN.exec(sql_string)
    if numbers.ntuples > 0
      numbers.each { |phone_label| @phone << { phone: phone_label['phone'], label: phone_label['label'] } }
    end
  end

  def destroy
    CONN.exec_params('DELETE FROM contacts WHERE id = $1', [@id])
    CONN.exec_params('DELETE FROM phones WHERE id = $1', [@id])
  end

  def self.destroy(id)
    CONN.exec_params('DELETE FROM contacts WHERE id = $1', [id])
    CONN.exec_params('DELETE FROM phones WHERE contact_id = $1', [id])
  end

  def self.find(id)
    con_obj = CONN.exec_params('SELECT * FROM contacts WHERE id = $1 LIMIT 1;', [id])
    result = nil
    if con_obj.ntuples > 0
      result = Contact.new(con_obj[0]['firstname'], con_obj[0]['lastname'], con_obj[0]['email'], id)
      result.get_phones
    end
    result
    # return single Contact (or nil)
  end
 
  def self.all
    results = []
    CONN.exec('SELECT * FROM contacts;').each do |tuple|
      # 'SELECT * FROM contacts LEFT JOIN phones ON id = contact_id;'
      # 'SELECT phone, label FROM contacts LEFT JOIN phones ON id = contact_id WHERE id = 20;'
      # phone_hash = { phone: tuple['phone'], label: tuple['label']}
      temp_contact = Contact.new(
        tuple['firstname'],
        tuple['lastname'],
        tuple['email'],
        tuple['id']
        # phone_hash
      )
      temp_contact.get_phones
      results << temp_contact
    end
    results # return array of Contacts (or empty array)
  end
 
  def self.find_all_by_lastname(lastname)
    results = []
    CONN.exec_params('SELECT * FROM contacts WHERE lastname = $1', [lastname]).each do |tuple|
      temp_contact = Contact.new(
        tuple['firstname'],
        lastname,
        tuple['email'],
        tuple['id']
      )
      temp_contact.get_phones
      results << temp_contact
    end
    results # return array of Contacts (or empty array)
  end

  def self.find_all_by_firstname(firstname)
    results = []
    CONN.exec_params('SELECT * FROM contacts WHERE firstname = $1', [firstname]).each do |tuple|
      temp_contact = Contact.new(
        firstname,
        tuple['lastname'],
        tuple['email'],
        tuple['id']
      )
      temp_contact.get_phones
      results << temp_contact
    end
    results # return array of Contacts (or empty array)
  end

  def self.find_by_email(email)
    con_obj = CONN.exec_params('SELECT * FROM contacts WHERE email = $1 LIMIT 1;', [email])
    result = nil
    if con_obj.ntuples > 0
      result = Contact.new(con_obj[0]['firstname'], con_obj[0]['lastname'], email, con_obj[0]['id'])
      result.get_phones
    end
    result
    # return either single contact (or nil)
  end
end