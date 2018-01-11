module ChartsNationality
  extend ActiveSupport::Concern

  included do
    helper_method :way_group
  end

  def self.filter_by_division(items, division)
    items = items.select { |profile_hash| profile_hash["division"] == division }
  end

  def self.item_counts(items)
    nationalities = items.map { |profile_hash| profile_hash["nationality"] }
    items_counts = GetItemsCountsHashService.execute(nationalities)
  end

  def self.way_group_data_x(items_counts)
    items_counts.keys.to_json.html_safe
  end

  def self.way_group_data_y(items_counts)
    items_counts.map { |key, value| value }
  end
  
end
