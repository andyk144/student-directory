@students = []

def input_students
  puts "You selected \"Input the students\""
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    update_students_list({name: name, cohort: :november})
    puts "We now have #{@students.count} students."
    name = gets.chomp
  end
end

def update_students_list(student_details)
  @students << (student_details)
end

def print_header
puts "The students of Villains Academy"
puts "-------------"
end

def print_students_list
  @students.each_with_index do |student, index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def show_students
  puts "You selected \"Show the students\""
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1" then input_students
  when "2" then show_students
  when "3" then save_students
  when "4" then load_menu
  when "9" then exit
  else
    puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  puts "Please enter a filename to save your student list to"
  puts "Hit return to save to students.csv"
  filename = STDIN.gets.chomp
  if filename.empty?
    filename = "students.csv"
  end
  File.open(filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    puts "Your students list has been saved succesfully to #{filename}"
  end
end

def load_menu
  puts "Please enter the name of the file to open"
  filecheck(STDIN.gets.chomp)
end

def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      update_students_list({name: name, cohort: cohort.to_sym})
    end
  puts "#{filename} loaded."
  puts "#{@students.count} students in the list"
  end
end

def try_load_students
  filename = ARGV.first
  filecheck(filename)
end

def filecheck(filename)
  @students.clear
  if filename.nil?
    load_students
  elsif File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
