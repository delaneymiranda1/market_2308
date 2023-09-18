class Market
  attr_reader :name, :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select { |vendor| vendor.inventory.key?(item) }
  end

  def sorted_item_list
    items = @vendors.flat_map { |vendor| vendor.inventory.keys }
    sorted_items = items.uniq.sort_by { |item| item.name }
    sorted_items.map(&:name)
  end

  def total_inventory
    inventory = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
       if inventory[item]
          inventory[item][:quantity] += quantity
          inventory[item][:vendors] << vendor
        else
          inventory[item] = { quantity: quantity, vendors: [vendor] }
        end
      end
    end
    inventory
  end

  
end