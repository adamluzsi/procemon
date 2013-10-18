module Procemon
  class << self

    def get_port(mint_port,max_port,host="0.0.0.0")

      require 'socket'
      mint_port= mint_port.to_i
      begin
        server = TCPServer.new(host, mint_port)
        server.close
        return mint_port
      rescue Errno::EADDRINUSE
        if mint_port < max_port
          pmint_portort = (mint_port.to_i + 1)
          retry
        end
      end

    end

    def port_open?(port,host="0.0.0.0")

      require 'socket'
      begin
        server = TCPServer.new(host, port.to_i)
        server.close
        return true
      rescue Errno::EADDRINUSE
        return false
      end

    end

  end
end
