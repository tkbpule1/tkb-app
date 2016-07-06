module StaticPagesHelper
  def get_time()
    time = Time.new
    "#{time.hour}:#{time.min}:#{time.sec}"
  end
end
