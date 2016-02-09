Module: posix-sockets
Synopsis: Support for datagram sockets.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define abstract class <datagram-socket> (<socket>)
end;

define class <udp-socket> (<datagram-socket>)
end;
