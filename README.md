# KimsufiAvailability

Get and parse kimsufi servers availabilities from OVH https://ws.ovh.com/dedicated/r2/ws.dispatcher/getAvailability2

    $ gem install kimsufi-availability    
    [1] pry(main)> require 'kimsufi-availability'
    [2] pry(main)> kimsufi = KimsufiAvailability.new
    [3] pry(main)> kimsufi.availabilities
    => {"ks2"=>[], "ks3"=>["rbx", "bhs"], "ks4"=>["sbg", "rbx", "bhs"], "ks5a"=>["rbx"], "ks6"=>[], "ks5b"=>["rbx"], "ks1"=>[]}
    [4] pry(main)> kimsufi.ks1
    => false
    [5] pry(main)> kimsufi.ks4
    => ["sbg", "rbx", "bhs"]
