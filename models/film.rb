require_relative('customer')
require_relative('ticket')
require_relative('../db/sql_runner')


class Film

  attr_accessor :title, :price, :id

  def initialize(options)
    @title = options['title']
    @price = options['price']
    @id = options['id'].to_i if options['id']
  end


  def save()
    sql = "INSERT INTO films
    (
    title,
    price
    ) VALUES
    ($1, $2
    )
    RETURNING id"
    values = [@title, @price]
    @id = SqlRunner.run( sql, values )[0]["id"].to_i()
  end


  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new( film) }
    return result
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def customers
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON
            customers.id = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    customer_hashes = SqlRunner.run(sql, values)
    return customer_hashes.map {|customer| Customer.new(customer)}
  end





end
