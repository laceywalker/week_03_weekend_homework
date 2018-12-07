require_relative('film')
require_relative('ticket')
require_relative('../db/sql_runner')



class Customer

  attr_accessor :name, :funds, :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds']
    @id = options['id'].to_i if options['id']
  end


  def save()
    sql = "INSERT INTO customers
      (
      name,
      funds
      ) VALUES
      (
      $1, $2
      )
      RETURNING id"
      values = [@name, @funds]
      @id = SqlRunner.run( sql, values )[0]["id"].to_i()
    end


  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films
      sql = "SELECT films.* FROM films INNER JOIN tickets ON
            films.id = tickets.film_id WHERE tickets.customer_id = $1"
      values = [@id]
      film_hashes = SqlRunner.run(sql, values)
      return film_hashes.map {|film| Film.new(film)}
    end


end
