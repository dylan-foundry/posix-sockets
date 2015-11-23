Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define primary class <address-info> (<object>)
  constant slot address-info-family,
    required-init-keyword: family:;
  constant slot address-info-socket-type,
    required-init-keyword: socket-type:;
  constant slot address-info-protocol,
    required-init-keyword: protocol:;
  constant slot address-info-socket-address :: <socket-address>,
    required-init-keyword: socket-address:;
  constant slot address-info-canonical-name :: <string>,
    required-init-keyword: canonical-name:;
end;
