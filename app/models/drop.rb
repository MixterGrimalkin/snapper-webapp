class Drop < ApplicationRecord

  has_many :snaps

  def src
    self.image_location ? self.image_location.gsub('public/', '') : ''
  end

  def send_email
    data = {}
    data[:from] = "Greenpeace at Glastonbury <mailgun@#{ENV['MG_DOMAIN']}>"
    data[:to] = self.email
    data[:subject] = "Thanks for dropping by!"
    data[:text] = "Well done for riding the drop slide! Here's a picture of you enjoying it."
    # data[:html] = "<html>HTML version of the body</html>"
    data[:attachment] = []
    data[:attachment] << File.new(File.join(self.image_location.split('/')))
    RestClient.post "https://api:#{ENV['MG_KEY']}@api.mailgun.net/v3/#{ENV['MG_DOMAIN']}/messages", data
  end

end
