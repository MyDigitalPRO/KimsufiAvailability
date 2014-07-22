require 'json'
require 'open-uri'

class KimsufiAvailability

  SERVER_STATUS_URI = 'https://ws.ovh.com/dedicated/r2/ws.dispatcher/getAvailability2'

  %w(ks1 ks2 ks3 ks4 ks5a ks5b ks6).each do |server|
    define_method(server) { availabilities[server].empty? ? false : availabilities[server] }
  end

  def availabilities
    @availabilities || update
  end

  def update
    @availabilities = simplify_kimsufi_hash JSON.parse open(SERVER_STATUS_URI).read
  end

  private

  def simplify_kimsufi_hash hash
    hash = hash['answer']['availability'].select{|e| e['reference']['sk']}
    availabilities = {}
    hash.each do |ks|
      next if server_mapping[ks['reference']].nil?
      zones = []
      ks['zones'].each do |zone|
        zones << zone['zone'] if zone['availability'] != 'unavailable'
      end
      availabilities[server_mapping[ks['reference']]] = zones
    end
    availabilities
  end

  def server_mapping
    {
      '142sk9' => 'ks1',
      '142sk2' => 'ks2',
      '142sk3' => 'ks3',
      '142sk4' => 'ks4',
      '142sk5' => 'ks5a',
      '142sk8' => 'ks5b',
      '142sk6' => 'ks6',
    }
  end

end
