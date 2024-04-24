
class MetaTagService
  def self.defaults
    {
      site: "Gymbuds",
      image: ActionController::Base.helpers.asset_url('gymbuds-logo.png'),
      description: "Find a gymbuddy, just a swipe away!",
      og: {
        title: "Gymbuds",
        image: ActionController::Base.helpers.asset_url('gymbuds-logo.png'),
        description: "Find a gymbuddy, just a swipe away!",
        site_name: "Gymbuds"
      }
    }
  end
end
