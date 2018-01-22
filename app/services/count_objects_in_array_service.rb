class CountObjectsInArrayService
	def initialize(attributes)
		# @item = attributes
	end

	def self.execute(items_to_be_count)
		items_counts = Hash.new 0
		items_to_be_count.each do |item|
		  items_counts[item] += 1
		end

		return items_counts
	end
end