Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define sealed class <socket-inet-address> (<socket-address>)
end class;

define sealed method socket-address-port
    (socket-address :: <socket-inet-address>)
 => (port :: false-or(<integer>))
  let s* = pointer-cast(<sockaddr-in*>, socket-address-sockaddr(socket-address));
  ntohs(sockaddr-in$sin-port(s*))
end method socket-address-port;

define sealed method socket-address-internet-address
    (sa :: <socket-inet-address>)
 => (internet-address :: <string>)
  let sa = pointer-cast(<sockaddr-in*>, sa.socket-address-sockaddr);
  let ia = sockaddr-in$sin-addr(sa);
  let buf = make(<byte-vector>, size: $INET-ADDRSTRLEN,
                 fill: as(<integer>, '\0'));
  with-C-string(ip-address = buf)
    %inet-ntop($AF-INET, ia, ip-address, $INET-ADDRSTRLEN);
    as(<byte-string>, ip-address)
  end with-C-string
end method socket-address-internet-address;

define method as
    (cls == <string>, sa :: <socket-inet-address>)
 => (string :: <string>)
  concatenate(sa.socket-address-internet-address,
              ":",
              integer-to-string(sa.socket-address-port))
end method as;
