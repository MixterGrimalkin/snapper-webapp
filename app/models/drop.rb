class Drop < ApplicationRecord

  def src
    self.image_location ? self.image_location.gsub('public/', '') : ''
  end

  def safe_name
    self.name.present? ? self.name : 'Greenpeace Visitor'
  end

  def send_email
    if (config = MailgunConfig.first) && self.email.present?
      data = {}
      data[:from] = 'Greenpeace at Glastonbury <info@greenpeace.org>'
      data[:to] = self.email
      data[:subject] = 'Thanks for dropping by!'
      data[:text] =
          %Q{
Dear #{self.safe_name},

Well done for riding the drop slide! Here's a picture of you enjoying it, for you to share.

Greenpeace"
}
      # data[:html] = "<html>HTML version of the body</html>"
      data[:attachment] = [File.new(File.join(self.image_location.split('/')))]
      RestClient.post "https://api:#{config.api_key}@api.eu.mailgun.net/v3/#{config.domain}/messages", data
    end
  end

end
