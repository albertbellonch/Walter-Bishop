class GetTorrentForEpisodeWorker
  include Sidekiq::Worker

  def perform(episode_id)
    episode = Episode.find(episode_id)

    if WalterBishop::Reese.get_torrent(episode)
      WalterBisshop::Tyrion.enqueue_torrent(episode)
    else
      perform_in(2.hours, episode_id)
    end
  end
end
