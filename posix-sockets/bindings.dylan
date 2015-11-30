Module: posix-sockets
Synopsis: Bindings for the raw functions.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define method get-address-info
    (hostname :: <string>,
     servname :: <string>,
     #key family-hint :: <integer> = $PF-UNSPEC,
          socktype-hint :: <integer> = 0,
          protocol-hint :: <integer> = 0,
          flags-hint :: <integer> = 0)
 => (addresses :: limited(<vector>, of: <address-info>))
  with-stack-structure(hints :: <addrinfo*>)
    clear-memory!(hints, size-of(<addrinfo>));
    addrinfo$ai-family(hints) := family-hint;
    addrinfo$ai-socktype(hints) := socktype-hint;
    addrinfo$ai-protocol(hints) := protocol-hint;
    addrinfo$ai-flags(hints) := flags-hint;
    with-stack-structure(addr-list :: <addrinfo**>)
      let res = %getaddrinfo(hostname, servname, hints, addr-list);
      let addresses = make(<stretchy-vector>);
      let addr :: <addrinfo*> = addr-list[0];
      while (~null-pointer?(addr))
        let family = addrinfo$ai-family(addr);
        let raw-sockaddr = addrinfo$ai-addr(addr);
        let addrlen = addrinfo$ai-addrlen(addr);
        let sockaddr = make(<socket-address>,
                            sockaddr: raw-sockaddr,
                            sockaddr-length: addrlen);
        add!(addresses, make(<address-info>,
                             family: family,
                             socket-type: addrinfo$ai-socktype(addr),
                             protocol: addrinfo$ai-protocol(addr),
                             socket-address: sockaddr,
                             canonical-name: addrinfo$ai-canonname(addr)));
        addr := addrinfo$ai-next(addr);
      end while;
      %freeaddrinfo(addr-list[0]);
      as(limited(<vector>, of: <address-info>), addresses)
    end with-stack-structure
  end with-stack-structure
end method get-address-info;

define inline method socket
    (address-family :: <integer>, socket-type :: <integer>,
     protocol :: <integer>)
 => (socket :: <unbound-socket>)
  let fd = %socket(address-family, socket-type, protocol);
  make(<unbound-socket>, file-descriptor: fd)
end method socket;

define inline method bind
    (socket :: <unbound-socket>, sa :: <socket-address>)
 => (socket :: <bound-socket>, res)
  let fd = socket.socket-file-descriptor;
  let res = %bind(fd,
                  sa.socket-address-sockaddr,
                  sa.socket-address-sockaddr-length);
  let socket = make(<bound-socket>,
                    file-descriptor: fd,
                    socket-address: sa);
  values(socket, res)
end method bind;

define inline method listen
    (socket :: <bound-socket>, backlog :: <integer>)
 => (socket :: <server-socket>, res)
  let fd = socket.socket-file-descriptor;
  let res = %listen(fd, backlog);
  let socket = make(<server-socket>,
                    file-descriptor: fd,
                    socket-address: socket.socket-address);
  values(socket, res)
end method listen;

define inline method accept
    (server-socket :: <server-socket>)
 => (socket :: <socket>)
  with-stack-structure(their-address :: <sockaddr*>)
    clear-memory!(their-address, size-of(<sockaddr-storage>));
    with-stack-structure(address-size :: <C-int*>)
      pointer-value(address-size) := size-of(<sockaddr-storage>);
      let fd = %accept(server-socket.socket-file-descriptor,
                       their-address,
                       address-size);
      let sa = make(<socket-address>,
                    sockaddr: their-address,
                    sockaddr-length: pointer-value(address-size));
      make(<ready-socket>,
           file-descriptor: fd,
           local-socket-address: server-socket.socket-address,
           peer-socket-address: sa);
    end with-stack-structure
  end with-stack-structure
end method accept;

define inline method connect
    (socket :: <unbound-socket>, address-info :: <address-info>)
 => (socket :: <ready-socket>, res)
  // This should actually be returning a <pending-socket> if
  // the socket is a non-blocking socket.
  let fd = socket.socket-file-descriptor;
  let sockaddr = address-info.address-info-socket-address;
  let res = %connect(fd,
                     sockaddr.socket-address-sockaddr,
                     sockaddr.socket-address-sockaddr-length);
  let s = make(<ready-socket>,
               file-descriptor: fd,
               local-socket-address: get-sock-name(socket),
               peer-socket-address: sockaddr);
  values(s, res)
end method connect;

define inline method close-socket (socket :: <socket>) => ()
  %close(socket.socket-file-descriptor);
end method close-socket;

define inline method shutdown-socket
    (socket :: <socket>, how :: <integer>)
 => ()
  %shutdown(socket.socket-file-descriptor, how);
end method shutdown-socket;

define method get-sock-name
    (socket :: <socket>)
 => (sa :: <socket-address>)
  with-stack-structure(rsa :: <sockaddr*>)
    clear-memory!(rsa, size-of(<sockaddr-storage>));
    with-stack-structure(rsa-size :: <C-int*>)
      pointer-value(rsa-size) := size-of(<sockaddr-storage>);
      %getsockname(socket.socket-file-descriptor, rsa, rsa-size);
      make(<socket-address>,
           sockaddr: rsa,
           sockaddr-length: pointer-value(rsa-size))
    end with-stack-structure
  end with-stack-structure
end;

define method get-peer-name
    (socket :: <socket>)
 => (sa :: <socket-address>)
  with-stack-structure(rsa :: <sockaddr*>)
    clear-memory!(rsa, size-of(<sockaddr-storage>));
    with-stack-structure(rsa-size :: <C-int*>)
      pointer-value(rsa-size) := size-of(<sockaddr-storage>);
      %getpeername(socket.socket-file-descriptor, rsa, rsa-size);
      make(<socket-address>,
           sockaddr: rsa,
           sockaddr-length: pointer-value(rsa-size))
    end with-stack-structure
  end with-stack-structure
end;

ignore(get-peer-name); // Nothing needs to use this yet.
