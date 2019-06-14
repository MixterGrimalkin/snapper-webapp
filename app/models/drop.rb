class Drop < ApplicationRecord

  has_many :snaps

  def src
    self.image_location.gsub('public/', '')
  end

end
