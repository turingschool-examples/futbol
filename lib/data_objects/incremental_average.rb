class IncrementalAverage

  attr_reader :average, :count

  def initialize(initial_sample = nil)
    @average = initial_sample
    @count = 0
    if initial_sample != nil
      @count = 1
    end
  end

  def add_sample(sample)
    @count += 1
    if @average == nil
      @average = sample.to_f
    else
      @average += (sample.to_f - @average) / @count
    end
  end
end
