class Events::Votes::MovesController < ApplicationController
  before_action :set_vote
  before_action :hackathon_ended

  def up
    @vote.move_higher
    redirect_to event_votes_url(@vote.entry.event)
  end

  def down
    @vote.move_lower
    redirect_to event_votes_url(@vote.entry.event)
  end

  private

  def set_vote
    @vote = current_user.votes.find(params[:vote_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to votes_url
  end
end
