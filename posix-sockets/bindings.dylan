Module: posix-sockets
Synopsis: Bindings for the raw functions.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define constant <byte-sequence> = type-union(<buffer>, type-union(<byte-vector>, <byte-string>));

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
 => (socket :: <bound-socket>)
  let fd = socket.socket-file-descriptor;
  %bind(fd,
        sa.socket-address-sockaddr,
        sa.socket-address-sockaddr-length);
  make(<bound-socket>,
       file-descriptor: fd,
       socket-address: sa)
end method bind;

define inline method listen
    (socket :: <bound-socket>, backlog :: <integer>)
 => (socket :: <server-socket>)
  let fd = socket.socket-file-descriptor;
  %listen(fd, backlog);
  make(<server-socket>,
       file-descriptor: fd,
       socket-address: socket.socket-address)
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
  %connect(fd,
           sockaddr.socket-address-sockaddr,
           sockaddr.socket-address-sockaddr-length);
  make(<ready-socket>,
       file-descriptor: fd,
       local-socket-address: get-sock-name(socket),
       peer-socket-address: sockaddr)
end method connect;

define inline method close (socket :: <socket>, #key) => ()
  %close(socket.socket-file-descriptor);
end method close;

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

define inline method recv
    (socket :: <ready-socket>,
     data :: <byte-sequence>,
     #key start: start-index :: <integer> = 0,
          end: end-index :: false-or(<integer>) = #f,
          msg-oob? :: <boolean> = #f,
          msg-peek? :: <boolean> = #f,
          msg-waitall? :: <boolean> = #f)
 => (size-sent :: <integer>)
  let end-index = end-index | data.size;
  let flags = 0;
  if (msg-oob?)
    flags := logior(flags, $MSG-OOB);
  end if;
  if (msg-peek?)
    flags := logior(flags, $MSG-PEEK);
  end if;
  if (msg-waitall?)
    flags := logior(flags, $MSG-WAITALL);
  end if;
  %recv(socket.socket-file-descriptor,
        byte-storage-offset-address(data, start-index),
        end-index - start-index, flags)
end method recv;

define inline method send
    (socket :: <ready-socket>,
     data :: <byte-sequence>,
     #key start: start-index :: <integer> = 0,
          end: end-index :: false-or(<integer>) = #f,
          msg-oob? :: <boolean> = #f,
          msg-dontroute? :: <boolean> = #f)
 => (size-sent :: <integer>)
  let end-index = end-index | data.size;
  let flags = 0;
  if (msg-oob?)
    flags := logior(flags, $MSG-OOB);
  end if;
  if (msg-dontroute?)
    flags := logior(flags, $MSG-DONTROUTE);
  end if;
  %send(socket.socket-file-descriptor,
        byte-storage-offset-address(data, start-index),
        end-index - start-index, flags)
end method send;
