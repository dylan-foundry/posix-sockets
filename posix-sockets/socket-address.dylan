Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define abstract primary class <socket-address> (<object>)
  constant slot socket-address-family,
    required-init-keyword: family:;
  constant slot socket-address-sockaddr :: <sockaddr*>,
    required-init-keyword: sockaddr:;
  constant slot socket-address-sockaddr-length :: <integer>,
    required-init-keyword: sockaddr-length:;
end class;

define sealed generic socket-address-port
    (socket-address :: <socket-address>)
 => (port :: false-or(<integer>));

define sealed class <socket-inet-address> (<socket-address>)
end class;

define sealed method socket-address-port
    (socket-address :: <socket-inet-address>)
 => (port :: false-or(<integer>))
  let s* = pointer-cast(<sockaddr-in*>, socket-address-sockaddr(socket-address));
  sockaddr-in$sin-port(s*)
end method socket-address-port;

define sealed class <socket-inet6-address> (<socket-address>)
end class;

define sealed method socket-address-port
    (socket-address :: <socket-inet6-address>)
 => (port :: false-or(<integer>))
  let s* = pointer-cast(<sockaddr-in6*>, socket-address-sockaddr(socket-address));
  sockaddr-in6$sin6-port(s*)
end method socket-address-port;

define sealed class <socket-unknown-address> (<socket-address>)
end class;

define sealed method socket-address-port
    (socket-address :: <socket-unknown-address>)
 => (port :: false-or(<integer>))
  #f
end method socket-address-port;
