Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define primary class <socket-address> (<object>)
  constant slot socket-address-family,
    required-init-keyword: family:;
  constant slot socket-address-port,
    required-init-keyword: port:;
  constant slot socket-address-data :: <sockaddr*>,
    required-init-keyword: data:;
  constant slot socket-address-data-length :: <integer>,
    required-init-keyword: data-length:;
  constant slot socket-address-internet-address,
    required-init-keyword: internet-address:;
end;
