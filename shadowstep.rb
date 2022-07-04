$ftb = ['front', 'back']
$sts = ['left', 'right']
$d4 = ['front', 'back', 'right', 'left']


class Shadowstep
  def initialize(set,interval,duration)
    @set = set
    @interval = interval
    @duration = duration
  end

  def training
  @set = $d4
  counter = 0
  until counter == @duration
    puts @set[rand(@set.size)]
    sleep @interval
    counter+= @interval
  end
  end
end

Shadowstep.new(1,0.5,5).training