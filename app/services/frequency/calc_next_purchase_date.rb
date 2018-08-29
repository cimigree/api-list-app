# add an attribute to the database that adds a time purchased? when an item is saved if purchased had been false and now it is true, add date

# generate list to display based on purchased true. use frequency to change purchased back to false

#could be a foreign key that saves a date each time purchased is marked true to use machine learning to suggest new frequency
module Frequency
  class CalcNextPurchaseDate
    def self.process(options)
      obj = new(options)
      obj.run
    end

    def initialize
      @item = Item.find(options)
      @days = 0
    end

    def run
      find_frequency
      add_time!
    end

    def find_frequency
      frequency = @item.frequency
      case frequency
      when '1 week' then @days=6
      when 'semi-monthly' then @days=14
      when 'monthly' then @days=29
      when 'as needed' then @days=180
      end
    end

    def add_time!
      next_purchase_date = @item.date_purchased + @days
      @item.update(next_purchase_date: next_purchase_date)
    end
  end
end
