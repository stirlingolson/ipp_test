require 'net/http'

class IPP

  IPP_MAJOR_VERSION = 1
  IPP_MINOR_VERSION = 1
  IPP_PRINT_JOB = 0x000b #0x0002
  REQUEST_ID = 14

  def print_stuff
    Net::HTTP.start( 'west-printer.boulder.foraker.com', 631 ) do |http|

      puts http.inspect

      http.request_post( '/', request ) do |response|
        p response.status
        p response['content-type']
        response.read_body do |str|   # read body now
          print str
        end
      end
    end
  end

  def request
    array = [ IPP_MAJOR_VERSION, IPP_MINOR_VERSION, IPP_PRINT_JOB, REQUEST_ID ]
    array.pack("CCnN");
  end

end

ipp = IPP.new
ipp.print_stuff