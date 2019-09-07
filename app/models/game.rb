class Game < ApplicationRecord
  require 'json'
  require 'open-uri'

  def can_edit?
    if self.scheduled_at > DateTime.now
      puts "Mayor QUE"
      return true
    else
      found = false
      puts "WHAAAT"
      data = JSON.load(open("http://www.nfl.com/liveupdate/scores/scores.json"))

      data.each do |a, b|
        if a.to_i == self.id
          found = true
          if b['qtr'] != nil and b['qtr'] != 'Pregame'
            self.editable = false
            self.save
            return false
          else
            return true
          end
        end
      end
      if !found
        self.editable = false
        self.save
        return false
      end
    end
  end
end
