require_relative('film')
require_relative('customer')
require_relative('../db/sql_runner')

class Ticket

  attr_accessor :customer_id, :film_id, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @customer_id = options['customer_id']
  end

  def save()
        sql = "INSERT INTO tickets
        (
            film_id,
            customer_id
        ) VALUES
        (
        $1, $2
        )
        RETURNING id"
        values = [@film_id, @customer_id]
        @id = SqlRunner.run( sql, values )[0]["id"].to_i()
      end


  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map { |ticket| Ticket.new( ticket) }
    return result
  end


  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end






end
