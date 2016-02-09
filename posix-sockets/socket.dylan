Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define primary abstract class <socket> (<closable-object>)
  constant slot socket-file-descriptor :: <integer>,
    required-init-keyword: file-descriptor:;
end;

// This is for people who have a file descriptor from
// somewhere else, like via PQsocket in Postgres and
// want to be able to interact with it in a select
// or poll.
define class <external-socket> (<socket>)
end;
