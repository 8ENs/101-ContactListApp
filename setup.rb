require 'pry'
require 'active_record'
require 'dotenv'
Dotenv.load
require 'pg'

# Output messages from AR to STDOUT
# ActiveRecord::Base.logger = Logger.new(STDOUT)

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

require_relative 'contact'
require_relative 'phone'
require_relative 'repl'