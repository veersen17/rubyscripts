require 'pg'
require 'rexml/document'
require 'nokogiri'
class DnConnecetion
     
    def initialize 
            @host = String('localhost')
            @database = String('ups_shipment')
            @user = String('postgres')
            @password = String('user@123')
     end
     def setConnecetion 
        begin
            @connection = PG::Connection.new(:host => @host, :user => @user, :dbname => @database, :port => '5432', :password => @password)            
           # puts 'Successfully created connection to database'
            
         end
     end

      def create (table,data)       
        col =  data.keys.map{|k| "#{k}" }.join(", ")
        result =  data.values.map{|v| "'#{v}'" }.join(", ")     
       # p "INSERT INTO #{table} (#{col}) VALUES(#{result});"
        res=@connection.exec ("INSERT INTO #{table} (#{col}) VALUES(#{result});")      
      end    
        
end

class DataParseXML< DnConnecetion
    def initialize
        super()
    end
    def processXMLDoc(fileName)
        filename=fileName
        xmlfile = File.read(filename) 
        @doc = Nokogiri::XML(xmlfile)
        trackingNo=@doc.css("Package TrackingNumber").text
       if !trackingNo.nil? && !trackingNo.empty?          
         #set shipper values in the DB
        createShipper()
        createShipmentDetails()
        createActivityDetails()
       end
    end 
    def create (table,data)
        super(table,data)
    end
    #create Shipper Data
    def  createShipper
        #set shipper values in the DB
        shipperdetails = {'shipper_number'=>@doc.css('Shipper ShipperNumber').text, 
            'address_line1'=>@doc.css('Shipper AddressLine1').text,
            'shipper_city'=>@doc.css('Shipper City').text, 
            'shipper_state_province_code'=>@doc.css('Shipper StateProvinceCode').text,
            'shipper_county_code'=>@doc.css('Shipper CountryCode').text
            }
        create('shipper_details',shipperdetails)
    end    
    #create Shipment Data
    def  createShipmentDetails
        #set shipper values in the DB
        shipmentDetails = { 'traking_number'=>@doc.css('Package TrackingNumber').text,                             
                            'shipping_city'=>@doc.css('ShipTo Address City').text, 
                            'shipping_state_province'=>@doc.css('ShipTo Address StateProvinceCode').text,
                            'shipping_postal_code'=>@doc.css('ShipTo Address PostalCode').text,
                            'shipping_county_code'=>@doc.css('ShipTo Address City').text,
                            'service_code'=>@doc.css('Service Code').text,
                            'service_description'=>@doc.css('Service Description').text,
                            'reference_number_code'=>@doc.css('ReferenceNumber Code').text,
                            'reference_number_value'=>@doc.css('ReferenceNumber Value').text,
                            'shipment_pickup_date'=>@doc.css('PickupDate').text,
                            'delivery_type'=>@doc.css('DeliveryDateUnavailable Type').text,
                            'delivery_description'=>@doc.css('DeliveryDateUnavailable Description').text,
                            'package_weight'=>@doc.css('PackageWeight Weight').text,
                            'weight_units_of_measure'=>@doc.css('PackageWeight  UnitOfMeasurement Code').text,
                            
                           }
       
       create('shipment_details',shipmentDetails)
    end    
    
    #create Activity Data    
    def  createActivityDetails
        block = @doc.xpath("//Package/Activity")
        chld_name = block.map do |node|
        #data=  node.children.map{|n| [n.name,n.text.strip] if n.elem? }.compact
        activityDetails = { 'city'=>node.css('ActivityLocation Address City').text,                             
            'state_province_code'=>node.css('ActivityLocation Address StateProvinceCode').text, 
            'county_code'=>node.css('ActivityLocation Address CountryCode').text,            
            'activity_code'=>node.css('ActivityLocation Code').text,
            'activity_description'=>node.css('ActivityLocation Description').text,
            'activity_status_code'=>node.css('Status StatusCode Code').text,
            'activity_status_type_code'=>node.css('Status StatusType Code').text,
            'activity_status'=>node.css('Status StatusType Description').text,
            'created_date'=>node.css('Date').text,
            'created_time'=>node.css('Time').text,    
           }
           create('shipment_activity',activityDetails)
        
        end
    end    

end  

parseObj=DataParseXML.new
if parseObj.setConnecetion
    parseObj.processXMLDoc('tracking.xml')
end    