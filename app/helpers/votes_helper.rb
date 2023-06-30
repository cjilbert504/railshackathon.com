module VotesHelper
  def voting_button_for(entry)
    if user_signed_in? && current_user.voted_for_entry?(entry: entry)
      button_to "Remove vote", vote_path(current_user.vote_for_entry(entry)), method: :delete, class: "mt-6 btn btn-white", data: { turbo_confirm: "Are you sure?" }
    else
      button_to "Vote for this application", votes_path(entry: entry), class: "mt-6 btn bg-green-500 text-white hover:bg-green-400"
    end
  end
end
