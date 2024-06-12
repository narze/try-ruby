#!/usr/bin/env ruby

require 'irb'
require 'io/console'

# Get the file to load from the first argument, default to "hello.rb" if not provided
file = ARGV[0] || "hello.rb"

# Check if the file exists
unless File.exist?(file)
  puts "File not found: #{file}"
  exit 1
end

# Load and evaluate the file in the IRB binding context with error handling
def load_file_in_irb_binding(file, irb_binding)
  begin
    irb_binding.eval(File.read(file))
    puts "Loaded #{file} successfully."
  rescue => e
    puts "Error loading #{file}: #{e.message}"
    puts e.backtrace
  end
end

# Function to send SIGTERM to the parent process (rerun)
def send_sigterm_to_parent
  parent_pid = Process.ppid
  puts "\nSending SIGTERM to parent process (PID: #{parent_pid}) to stop rerun..."
  Process.kill("TERM", parent_pid)
end

puts "Loading #{file} and starting IRB session..."

# Start an IRB session and load the file initially
begin
  IRB.setup(nil)
  workspace = IRB::WorkSpace.new(binding)
  irb = IRB::Irb.new(workspace)
  IRB.conf[:MAIN_CONTEXT] = irb.context

  # Load the file initially in the IRB binding context with error handling
  irb_binding = irb.context.workspace.binding
  load_file_in_irb_binding(file, irb_binding)

  trap("SIGINT") do
    irb.signal_handle
  end

  catch(:IRB_EXIT) do
    irb.eval_input
  end

  send_sigterm_to_parent
rescue Interrupt
  puts "\nExiting gracefully. Goodbye!"
  send_sigterm_to_parent
  exit 0
end
