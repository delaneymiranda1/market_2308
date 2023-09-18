require 'date'

class Market
  attr_reader :name, :vendors, :date
  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today.strftime('%d/%m/%Y')
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

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, info|
      if info[:quantity] > 50 && info[:vendors].size > 1
        overstocked_items << item
      end
    end
    overstocked_items
  end

end