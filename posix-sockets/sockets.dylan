Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define primary class <socket> (<object>)
  constant slot socket-file-descriptor :: <integer>,
    required-init-keyword: file-descriptor:;
end;

define inline method socket
    (address-family :: <integer>, socket-type :: <integer>,
     protocol :: <integer>)
 => (socket :: <socket>)
  let fd = %socket(address-family, socket-type, protocol);
  make(<socket>, file-descriptor: fd)
end method socket;

define inline method bind
    (socket :: <socket>, socket-address :: <socket-address>)
 => (res)
  %bind(socket.socket-file-descriptor,
        socket-address.socket-address-data,
        size-of(<sockaddr>));
end method bind;

define inline method listen
    (socket :: <socket>, backlog :: <integer>)
 => (res)
  %listen(socket.socket-file-descriptor, backlog)
end method listen;

define inline method accept
    (server-socket :: <socket>)
 => (socket :: <socket>)
  with-stack-structure(their-address :: <sockaddr*>)
    clear-memory!(their-address, size-of(<sockaddr>));
    with-stack-structure(address-size :: <C-int*>)
      pointer-value(address-size) := size-of(<sockaddr>);
      let fd = %accept(server-socket.socket-file-descriptor,
                       their-address,
                       address-size);
      make(<socket>, file-descriptor: fd)
    end with-stack-structure
  end with-stack-structure
end method accept;

define inline method connect
    (socket :: <socket>, address-info :: <address-info>)
 => (res)
  let sockaddr = address-info.address-info-socket-address;
  %connect(socket.socket-file-descriptor,
           sockaddr.socket-address-data,
           sockaddr.socket-address-data-length)
end method connect;

define inline method close-socket (socket :: <socket>) => ()
  %close(socket.socket-file-descriptor);
end method close-socket;

define inline method shutdown-socket
    (socket :: <socket>, how :: <integer>)
 => ()
  %shutdown(socket.socket-file-descriptor, how);
end method shutdown-socket;
