class Drop < ApplicationRecord

  has_many :snaps

  def src
    self.image_location ? self.image_location.gsub('public/', '') : ''
  end

  def safe_name
    if self.name && !self.name.empty?
      self.name
    else
      'Greenpeace Visitor'
    end
  end

  def send_email
    if (config = MailgunConfig.first)
      data = {}
      data[:from] = "Greenpeace at Glastonbury <mailgun@#{config.domain}>"
      data[:to] = self.email
      data[:subject] = "Thanks for dropping by!"
      data[:text] = "Dear #{self.safe_name},\n\nWell done for riding the drop slide! Here's a picture of you enjoying it.\n\nGreenpeace Glastonbury Crew"
      # data[:html] = "<html>HTML version of the body</html>"
      data[:attachment] = [File.new(File.join(self.image_location.split('/')))]
      RestClient.post "https://api:#{config.api_key}@api.mailgun.net/v3/#{config.domain}/messages", data
    end
  end

end
