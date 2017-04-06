require 'csv'

class SunlightLegislatorsImporter
  def self.import(file_name)
    csv = CSV.new(File.open(file_name), :headers => true)
    csv.each do |row|
      attribute_hash = Hash.new
      row.each do |field, value|
        # TODO: begin
        if field == "title" 
          field = "type"
          if value == "Rep"
            value = "Representative"
          else 
            value = "Senator"
          end
        elsif field == 'phone'
          value.gsub!(/\D/,"")
        elsif (field == "nickname" || field == "district" || field == "congress_office" || field == "bioguide_id" || field == "votesmart_id" || field == "fec_id" || field == "govtrack_id" || field == "crp_id" || field == "congresspedia_url" || field == "youtube_url" || field == "facebook_id" || field == "official_rss" || field == "senate_class")
          next 
        end

        attribute_hash[field] = value
      end
        #raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
        # TODO: end
      legislator = Legislator.create!(attribute_hash)
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
