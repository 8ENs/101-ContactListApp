require 'pry'
require 'active_record'
require 'dotenv'
Dotenv.load
require 'pg'

require_relative 'contact'
require_relative 'repl'

# Output messages from AR to STDOUT
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing connection to database ..."
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  encoding: 'unicode',
  pool: 5,
  database: ENV['DB'],
  username: ENV['DBUSER'],
  password: ENV['PASS'],
  host: ENV['HOST'],
  port: ENV['PORT'],
  min_messages: 'error'
)
puts "CONNECTED"

puts "Setting up Database (recreating tables) ..."

ActiveRecord::Schema.define do
  drop_table :stores if ActiveRecord::Base.connection.table_exists?(:stores)
  drop_table :employees if ActiveRecord::Base.connection.table_exists?(:employees)
  create_table :stores do |t|
    t.column :name, :string
    t.column :annual_revenue, :integer
    t.column :mens_apparel, :boolean
    t.column :womens_apparel, :boolean
    t.timestamps
  end
  create_table :employees do |table|
    table.references :store
    table.column :first_name, :string
    table.column :last_name, :string
    table.column :hourly_rate, :integer
    table.timestamps
  end
end

puts "Setup DONE"

# Driver code

