class CatRentalRequest < ApplicationRecord
  STATUS_CODES = %w(PENDING APPROVED DENIED)
  validates :cat_id, :start_date, :end_date, :status, presence: true

  validates :status, inclusion: { in: STATUS_CODES }
  validate :does_not_overlap_approved_request

  belongs_to :cat,
    dependent: :destroy

  def overlapping_requests
    range = self.start_date..self.end_date

    conflicts_start = CatRentalRequest
      .where(cat_id: self.cat_id, start_date: range)

    conflicts_end = CatRentalRequest
      .where(cat_id: self.cat_id, end_date: range)

    conflicts_start.merge(conflicts_end)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
    overlapping_approved_requests.exists?
  end


end
