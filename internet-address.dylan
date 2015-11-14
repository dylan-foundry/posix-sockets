Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define primary class <internet-address> (<object>)
end class <internet-address>;

define class <ipv4-address> (<internet-address>)
  constant slot internet-address-data :: <in-addr>,
    required-init-keyword: data:;
end class <ipv4-address>;

define class <ipv6-address> (<internet-address>)
  constant slot internet-address-data :: <in6-addr>,
    required-init-keyword: data:;
end class <ipv6-address>;
