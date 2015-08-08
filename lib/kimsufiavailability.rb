require 'json'
require 'open-uri'

class KimsufiAvailability
  # https://ws.ovh.com/dedicated/r2/ws.dispatcher/getAvailability2
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
      ks['metaZones'].each do |zone|
        zones << zone['zone'] unless ['unavailable', 'unknown'].include?(zone['availability'])
      end
      availabilities[server_mapping[ks['reference']]] = zones
    end
    availabilities
  end

  def server_mapping
    {
      '150sk10' => 'ks1',
      '150sk20' => 'ks2',
      '150sk22' => 'ks2ssd',
      '150sk30' => 'ks3',
      '150sk40' => 'ks4',
      '150sk50' => 'ks5',
      '150sk60' => 'ks6',
    }
  end

end
