require "socket"

if ARGV.size <= 1
  puts <<-STRING
  
  Remote Shell Client
  
    Usage: client <address> <port>
    you should start the server first\n\n
  STRING
  exit
end

s = Socket.tcp(Socket::Family::INET)
puts "\nTrying to establish connection with server...\n"
begin
  s.connect ARGV[0], ARGV[1].to_i
  puts "\nClient is connected to the server\n"
rescue
  puts "\nConnection error\n"
  exit 1
end

while payload = s.receive[0].chomp
  stdout = IO::Memory.new
  p = Process.new(payload, shell: true, output: stdout)
  status = p.wait
  if status.to_s == "0"
    s.puts stdout.to_s
    s.puts "!EXECUTED!"
  elsif status.to_s == "127"
    s.puts "[Client Error]: Command not found"
    s.puts "!EXECUTED!"
  else
    s.puts "[Client Error]"
    s.puts "!EXECUTED!"
  end
end

s.close
