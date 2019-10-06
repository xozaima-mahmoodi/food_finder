# adad ghaymat ro be sorat poly minewisad


module NumberHelper

    def number_to_currency(number, options={})
        unit      = options[:unit]      || '$'  #wahed andaze gyri
        precision = options[:precision] || 2 #teadad adade ashari
        delimiter = options[:delimiter] || ','
        separator = options[:separator] || '.'

        separator = '' if precision == 0
        integer, desimal = number.to_s.split('.')

        i = integer.length
        until i <= 3
            i -= 3
            integer = integer.insert(i,delimiter)
        end
        
         if precision == 0
            precise_decimal = ''
         else

            decimal ||= "0" # or mosawi

            decimal = decimal [0,precision]

            precise_decimal = decimal.ljust(precision, "0")
         end

         return unit + integer + separator + precise_decimal
        end

end