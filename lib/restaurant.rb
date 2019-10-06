require 'support/number_helper'
class Restaurant

    include NumberHelper

    @@filepath = nil #motaghayer az jense class

    def self.filepath=(path=nil)
        @@filepath = File.join(APP_ROOT, path) 
    end

    attr_accessor :name, :cuisine, :price

    def initialize(args={})
        @name    = args[:name]    || ""
        @cuisine = args[:cuisine] || ""
        @price   = args[:price]   || ""
        
    end

    def self.build_using_questions
        args = {}
      
        print "Restaurant name: "
        args[:name] = gets.chomp.strip
  
        print "Cuisine type: "
        args[:cuisine] = gets.chomp.strip
  
        print "Average price: "
        args[:price] = gets.chomp.strip
  
        return self.new(args)
        
    end



    def formatted_price
        number_to_currency(@price)
    end

    
    
    def self.file_exists? #chon az kalemeh self estefadeh mikonand class metod hastand
        #class should know if the restaurant file exists
        if @@filepath && File.exists?(@@filepath)
            return true
        else
            return false
        end        
    end

    def self.file_usable?
        return false unless @@filepath
        return false unless File.exists?(@@filepath)
        return false unless File.readable?(@@filepath)
        return false unless File.writable?(@@filepath)
        return true
    end

    def self.create_file
        #creat file restaurant file
        File.open(@@filepath, 'w') unless file_exists?
        return file_usable?
    end

    def self.saved_restaurants
       restaurants = []
       if file_usable?
        file = File.new(@@filepath, 'r')
        file.each_line do |line|
            restaurants << Restaurant.new.import_line(line.chomp)
        end
        file.close
     end 
       return restaurants   
    end

    def import_line(line)
     line_array = line.split("\t")
     @name, @cuisine, @price = line_array
     return self  
    end

    def save
       return false unless Restaurant.file_usable?
       File.open(@@filepath, 'a') do |file|
        file.puts "#{[@name, @cuisine, @price].join("\t")}\n" 
       end
       return true
    end
end