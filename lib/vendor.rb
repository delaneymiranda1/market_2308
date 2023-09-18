class Vendor
  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    @inventory.fetch(item, 0)
  end

  def stock(item, quantity)
    before_stock = check_stock(item)
    @inventory[item] = before_stock + quantity
  end

  def potential_revenue
    @inventory.sum { |item, quantity| item.price * quantity }
  end
end