require './config/boot'
require './config/environment'

def process_drops
  Drop.where(status: 'WAITING').each do |drop|
    begin
      puts "Processing drop #{drop.id}...."
      if drop.send_by_email
        puts "Sending email to #{drop.email}"
        drop.send_email
        drop.sent_at = DateTime.now
      end
      drop.status = 'COMPLETE'
      drop.save
      puts 'Done'
    rescue => e
      drop.email_error = e.message
      drop.status = 'FAILED'
      drop.save
      puts "Error: #{e.message}"
    end
  end
end