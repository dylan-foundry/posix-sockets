Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define sealed class <socket-unknown-address> (<socket-address>)
end class;

define sealed method socket-address-port
    (socket-address :: <socket-unknown-address>)
 => (port :: false-or(<integer>))
  #f
end method socket-address-port;
