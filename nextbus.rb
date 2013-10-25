module NextBusInterface
  
  def self.stop_prediction_info(line,stop)
    predictions = Nokogiri::XML(open("http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=sf-muni&r=#{line}&s=#{stop}"))
    predictions.xpath('.//prediction')
  end

  def self.arrival_minutes(line,stop)
    stop_prediction_info(line,stop).map {|prediction| prediction[:minutes]}
  end

end