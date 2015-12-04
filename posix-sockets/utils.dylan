Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define inline function ntohs (network-short :: <integer>)
 => (host-short :: <integer>)
  if ($architecture-little-endian?)
    let byte0 = logand(network-short, #xff);
    let byte1 = logand(ash(network-short, -8), #xff);
    logior(ash(byte0, 8), byte1)
  else
    network-short
  end if
end function ntohs;
