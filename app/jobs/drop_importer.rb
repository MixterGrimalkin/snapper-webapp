require './config/boot'
require './config/environment'

def import_drops
  puts 'Searching for new Drops....'
  count = 0
  Dir.glob('public/snaps/*.gif') do |file|
    unless Drop.find_by(image_location: file)
      Drop.create!(image_location: file, status: 'PENDING')
      puts "Created Drop '#{file}'"
      count += 1
    end
  end
  puts "Imported #{count} drops."
end
