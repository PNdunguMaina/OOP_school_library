#!/usr/bin/env ruby
require_relative './book'
require_relative './person'
require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative './print_menu'

class App
  attr_accessor :books, :persons, :rentals

  def initialize
    @books = []
    @persons = []
    @rentals = []
  end

  def run
    puts 'Welcome to School Library App!'

    loop do
      menu = PrintMenu.new
      menu.print_menu

      print 'Enter your option:  '
      option = gets.chomp

      if option == '7'
        puts 'Goodbye!'
        break
      end

      execute(option)
    end
  end

  def execute(option)
    case option
    when '1'
      list_books

    when '2'
      list_people

    when '3'
      create_person

    when '4'
      create_book

    when '5'
      create_rental

    when '6'
      list_rentals

    else
      puts 'Invalid option! Try again!'
    end
  end

  def list_books
    if @books.empty?
      puts 'No books available!'
    else
      puts 'List of books available'
      puts '........................'
      @books.map { |book| puts "Title: #{book.title} Author: #{book.author}" }
    end
  end

  def list_people
    if @persons.empty?
      puts 'No list of persons available'
    else
      puts 'List of people'
      puts '...............'
      @persons.each { |person| puts "[id: #{person.id} Name: #{person.name} Age: #{person.age}]" }
    end
  end

  def create_person
    print 'Do you want to create a student(1) or a teacher(2)? [Enter the number]:'
    input = gets.chomp

    case input
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid choice! Try again!'
    end
  end

  def create_student
    puts 'creating student...'

    print 'Name: '
    name = gets.chomp

    print 'Age: '
    age = gets.chomp.to_i

    print 'Has parent permission? [Y/N]:'
    parent_permission = gets.chomp.upcase
    parent_permission = parent_permission == 'Y'

    student = Student.new(age, name, parent_permission: parent_permission)
    @persons.push(student)

    puts "Student #{name} created successfully"
  end

  def create_teacher
    puts 'creating teacher...'

    print 'Name: '
    name = gets.chomp

    print 'Age: '
    age = gets.chomp.to_i

    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(specialization, age, name)
    @persons.push(teacher)

    puts "Teacher #{name} created successfully"
  end

  def create_book
    puts 'Creating a book...'

    print 'Enter book title: '
    title = gets.chomp

    print 'Enter book author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books.push(book)

    puts "#{title}'s #{author} created successfully"
  end

  def create_rental
    puts 'Creating a rental...'

    puts 'Enter a number to select a book:'
    @books.each_with_index do |book, _index|
      puts "#{index}. Title: #{book.title} Author: #{book.author}"
    end
    book_index = gets.chomp.to_i

    puts 'Enter a number to select a person:'
    @persons.each_with_index do |person, index|
      puts "#{index}. #:#{person.id} Name: #{person.name} Age:#{person.age}"
    end
    person_index = gets.chomp.to_i

    print 'Enter date:'
    date = gets.chomp

    Rental.new(date, @books[book_index], @persons[person_index])

    puts 'Rental created successfully'
  end

  def list_rentals
    puts 'List all rentals with the person id'

    puts 'Enter the person id from the list below'
    @persons.each { |person| puts "[#: #{person.id} Name: #{person.name} Age: #{person.age}]" }
    id = gets.chomp

    puts 'Rentals'
    puts '........'
    @rentals.map do |rental|
      puts "Date: #{rental.date} - Book: #{rental.book.title} - Author: #{rental.book.author}" if rental.person.id == id
    end
  end
end
