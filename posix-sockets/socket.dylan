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

define class <unbound-socket> (<socket>)
end;

define method print-object
    (s :: <unbound-socket>, stream :: <stream>)
 => ()
  write-element(stream, '{');
  write(stream, s.object-class.debug-name);
  write-element(stream, '}');
end method print-object;

define sealed domain make(singleton(<unbound-socket>));
define sealed domain initialize(<unbound-socket>);

define class <bound-socket> (<socket>)
  constant slot socket-address :: <socket-address>,
    required-init-keyword: socket-address:;
end;

define sealed domain make(singleton(<bound-socket>));
define sealed domain initialize(<bound-socket>);

define method print-object
    (s :: <bound-socket>, stream :: <stream>)
 => ()
  write-element(stream, '{');
  write(stream, s.object-class.debug-name);
  write(stream, as(<string>, s.socket-address));
  write-element(stream, '}');
end method print-object;

define class <server-socket> (<socket>)
  constant slot socket-address :: <socket-address>,
    required-init-keyword: socket-address:;
end;

define sealed domain make(singleton(<server-socket>));
define sealed domain initialize(<server-socket>);

define method print-object
    (s :: <server-socket>, stream :: <stream>)
 => ()
  write-element(stream, '{');
  write(stream, s.object-class.debug-name);
  write(stream, as(<string>, s.socket-address));
  write-element(stream, '}');
end method print-object;

define class <ready-socket> (<socket>)
  constant slot local-socket-address :: <socket-address>,
    required-init-keyword: local-socket-address:;
  constant slot peer-socket-address :: <socket-address>,
    required-init-keyword: peer-socket-address:;
end;

define sealed domain make(singleton(<ready-socket>));
define sealed domain initialize(<ready-socket>);

define method print-object
    (s :: <ready-socket>, stream :: <stream>)
 => ()
  write-element(stream, '{');
  write(stream, s.object-class.debug-name);
  write(stream, " local: ");
  write(stream, as(<string>, s.local-socket-address));
  write(stream, " peer: ");
  write(stream, as(<string>, s.peer-socket-address));
  write-element(stream, '}');
end method print-object;
