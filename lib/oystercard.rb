class Oystercard

  BALANCE_LIMIT = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  attr_reader :balance
  attr_reader :entry_station, :journey

  def initialize
    @balance = 0
    @journey = {}
  end

  def top_up(amount)
    raise "Exceeds max allowed amount of #{BALANCE_LIMIT}" if balance_exceeds_limit?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise "insufficient funds" if balance < MIN_BALANCE
    @entry_station = entry_station
    journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @entry_station = nil
    journey[:exit_station] = exit_station
  end

  def in_journey?
     entry_station == nil ? false : true
  end

  private

  def balance_exceeds_limit?(amount)
    balance + amount > BALANCE_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

end
