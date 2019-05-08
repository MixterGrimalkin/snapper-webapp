class Drop < ApplicationRecord

  has_many :snaps

  def primary_snap
    if self.primary_snap_id
      Snap.find self.primary_snap_id
    else
      nil
    end
  end

  def primary_snap=(snap)
    if snap
      self.primary_snap_id = snap.id
    else
      self.primary_snap_id = nil
    end
    self.save
  end

end
