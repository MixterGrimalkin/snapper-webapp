require './config/boot'
require './config/environment'

def import_drops
  puts 'Searching for new Drops....'
  count = 0
  Dir.glob('public/snaps/*') do |file|
    if File.directory? file
      unless Drop.find_by(image_location: file)
        drop = Drop.create!(image_location: file, status: 'PENDING')
        Dir.glob("#{file}/*") do |image_file|
          Snap.create!(filename: image_file.gsub('public/', ''), drop: drop)
        end
        puts "Created Drop '#{file}' with #{drop.reload.snaps.count} images"
        count += 1
      end
    end
  end
  puts "Imported #{count} drops."
end
