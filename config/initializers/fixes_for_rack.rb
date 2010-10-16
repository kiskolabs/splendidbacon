module Rack
  module Utils
    def escape(s)
      s.to_s.gsub(/([^ a-zA-Z0-9_.-]+)/u) {
        '%'+$1.unpack('H2'*bytesize($1)).join('%').upcase
      }.tr(' ', '+')
    end
    module_function :escape

    def unescape(s)
      s.tr('+', ' ').gsub(/((?:%[0-9a-fA-F]{2})+)/u){
        [$1.delete('%')].pack('H*')
      }
    end
    module_function :unescape    
  end
end

