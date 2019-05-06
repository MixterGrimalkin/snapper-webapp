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
          DropImage.create!(filename: image_file.gsub('public/', ''), drop: drop)
        end
        puts "Creating Drop '#{file}' with #{drop.reload.drop_images.count} images"
        count += 1
      end
    end
  end
  puts "Imported #{count} drops."
end
