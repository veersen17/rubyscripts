require 'pg'

begin
	# Initialize connection variables.
	host = String('localhost')
	database = String('ups_shipment')
    user = String('postgres')
	password = String('user@123')

	# Initialize connection object.
    connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)
    puts 'Successfully created connection to database'

    # Drop previous table of same name if one exists
    connection.exec('DROP TABLE IF EXISTS status_type;')
    connection.exec('DROP TABLE IF EXISTS shipment_activity;')
    connection.exec('DROP TABLE IF EXISTS shipper_details;')
    connection.exec('DROP TABLE IF EXISTS shipment_details;')
    puts 'Finished dropping table (if existed).'

    # Drop previous table of same name if one exists.
    connection.exec('CREATE TABLE shipper_details (id serial PRIMARY KEY,
        shipper_number VARCHAR(20),
        address_line1 VARCHAR(100),
        shipper_city VARCHAR(100),        
        shipper_state_province_code VARCHAR(10),
        shipper_county_code VARCHAR(10));')

    connection.exec('CREATE TABLE shipment_details (id serial PRIMARY KEY,
        traking_number VARCHAR(100) NOT NULL,
        shipper_id BIGINT,
        shipping_city VARCHAR(10),
        shipping_state_province VARCHAR(10),
        shipping_postal_code VARCHAR(10),
        shipping_county_code VARCHAR(10),
        service_code VARCHAR(10),
        service_description VARCHAR(100),
        reference_number_code VARCHAR(10),
        reference_number_value VARCHAR(100),
        shipment_pickup_date timestamp without time zone,
        delivery_type VARCHAR(100),
        delivery_description VARCHAR(100),
        package_weight double precision,
        weight_units_of_measure VARCHAR(10),
        created_at timestamp without time zone);')

    connection.exec('CREATE TABLE status_type (id serial PRIMARY KEY,status_code VARCHAR(10), 
                                                description VARCHAR(10));')
   
    connection.exec('CREATE TABLE shipment_activity (id serial PRIMARY KEY,
                                                        traking_id BIGINT,
                                                        city VARCHAR(10),
                                                        state_province_code VARCHAR(10),
                                                        county_code VARCHAR(10),
                                                        status_type_id BIGINT,
                                                        activity_code VARCHAR(10),
                                                        activity_description VARCHAR(100),
                                                        activity_status_code VARCHAR(10),
                                                        activity_status_type_code VARCHAR(10),
                                                        activity_status VARCHAR(50),
                                                        created_date date,
                                                        created_time time with timezone,
                                                        description VARCHAR(10));')
    
    puts 'Finished creating table.'    
   
rescue PG::Error => e
    puts e.message 
    
ensure
    connection.close if connection
end

#INSERT INTO shipper_details ("shipper_number", "address_line1", "shipper_city", "shipper_state_province_code", "shipper_county_code") VALUES('123', 'XXX', 'SAN BERNARDINO', 'CA', 'US')

#INSERT INTO shipper_details ('shipper_number', 'address_line1', 'shipper_city', 'shipper_state_province_code', 'shipper_county_code') VALUES('123', 'XXX', 'SAN BERNARDINO', 'CA', 'US')
#SELECT * FROM shipper_details

#INSERT INTO shipment_details (traking_number, shipping_city, shipping_state_province, shipping_postal_code, shipping_county_code, service_code, service_description, reference_number_code, reference_number_value, shipment_pickup_date, delivery_type, delivery_description, package_weight, weight_units_of_measure) VALUES('ABC', 'WALHALLA', 'ND', '58282', 'WALHALLA', '003', 'GROUND', '0101010101', '123123123123123', '20150413', 'Scheduled Delivery', 'Scheduled Delivery Date is not currently available, please try back later', '3.00', 'LBS')

#INSERT INTO shipment_activity (city, state_province_code, county_code, activity_code, activity_description, activity_status_code, activity_status_type_code, activity_status, created_date, created_time) VALUES('ONTARIO', 'CA', 'US', '', '', 'DP', 'I', 'DEPARTURE SCAN', '20150414', '072300')
#select * FROM shipment_activity;