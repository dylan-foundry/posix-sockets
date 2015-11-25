Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define primary class <socket> (<object>)
  constant slot socket-file-descriptor :: <integer>,
    required-init-keyword: file-descriptor:;
end;
