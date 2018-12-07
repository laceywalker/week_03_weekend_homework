require_relative('../models/customer')
require_relative('../models/ticket')
require_relative('../models/film')

require( 'pry-byebug' )
require( 'pry-byebug' )


Ticket.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new('name' => 'Bianca Jones', 'funds' => '10')
customer2 = Customer.new('name' => 'Jim Jones', 'funds' => '20')
customer3 = Customer.new('name' => 'Happy Jones', 'funds' => '30')

customer1.save
customer2.save
customer3.save


film1 = Film.new('title' => 'Grapes of Wrath', 'price' => '1')
film2 = Film.new('title' => 'Fantasia', 'price' => '2')

film1.save
film2.save

ticket1 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id)
ticket2 = Ticket.new('customer_id' => customer2.id, 'film_id' => film2.id)
ticket3 = Ticket.new('customer_id' => customer3.id, 'film_id' => film2.id)

ticket1.save
ticket2.save
ticket3.save


binding.pry
nil
