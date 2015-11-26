Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define primary class <socket> (<object>)
  constant slot socket-file-descriptor :: <integer>,
    required-init-keyword: file-descriptor:;
end;

define class <unbound-socket> (<socket>)
end;

define sealed domain make(singleton(<unbound-socket>));
define sealed domain initialize(<unbound-socket>);

define class <bound-socket> (<socket>)
end;

define sealed domain make(singleton(<bound-socket>));
define sealed domain initialize(<bound-socket>);

define class <server-socket> (<socket>)
end;

define sealed domain make(singleton(<server-socket>));
define sealed domain initialize(<server-socket>);
