class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :entry, counter_cache: true
  belongs_to :event
  has_one :team, through: :entry

  acts_as_list scope: [:user_id, :event_id]

  validates :entry_id, uniqueness: {scope: :user_id}
  validate :user_can_have_only_five_votes

  after_commit :update_entry_vote_points, :distribute_user_vote_points_to_entries

  MAXIMUM = 5

  def user_can_have_only_five_votes
    if user.votes.where(event: event).size >= MAXIMUM
      errors.add(:base, "You've reached the #{MAXIMUM} vote limit")
    end
  end

  def update_entry_vote_points
    entry.update_entry_total_points
  end

  private

  def distribute_user_vote_points_to_entries
    user.votes.each &:update_entry_vote_points
  end
end
