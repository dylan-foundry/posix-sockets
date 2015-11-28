Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define sealed class <socket-inet6-address> (<socket-address>)
end class;

define sealed method socket-address-internet-address
    (sa :: <socket-inet6-address>)
 => (internet-address :: <string>)
  let sa = pointer-cast(<sockaddr-in6*>, sa.socket-address-sockaddr);
  let ia = sockaddr-in6$sin6-addr(sa);
  let buf = make(<byte-vector>, size: $INET6-ADDRSTRLEN,
                 fill: as(<integer>, '\0'));
  with-C-string(ip-address = buf)
    %inet-ntop($AF-INET6, ia, ip-address, $INET6-ADDRSTRLEN);
    as(<byte-string>, ip-address)
  end with-C-string
end method socket-address-internet-address;

define sealed method socket-address-port
    (socket-address :: <socket-inet6-address>)
 => (port :: false-or(<integer>))
  let s* = pointer-cast(<sockaddr-in6*>, socket-address-sockaddr(socket-address));
  sockaddr-in6$sin6-port(s*)
end method socket-address-port;

define method as
    (cls == <string>, sa :: <socket-inet6-address>)
 => (string :: <string>)
  concatenate("[", sa.socket-address-internet-address, "]",
              ":",
              integer-to-string(sa.socket-address-port))
end method as;
