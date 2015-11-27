Module: posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

// We don't want to manage a <sockaddr> via C-FFI directly
// as that would require us to call destroy() on it, which
// would complicate memory management. Instead, we'll
// allocate a buffer of the appropriate size and copy the
// sockaddr into this buffer. We'll also have a typed
// pointer (<sockaddr*>) to the storage area of that buffer
// so that things expecting a <sockaddr*> pointer can
// get one.
//
// This is unsafe as someone could keep around a reference
// to our <sockaddr*> after the <socket-address> has gone
// away. To solve that, we need an extension to C-FFI
// that provides a subtype of <C-pointer> that knows
// not just an address, but also can maintain a reference
// to the object whose storage contains that address.

define abstract primary class <socket-address> (<object>)
  constant slot socket-address-sockaddr-buffer :: <byte-vector>,
    required-init-keyword: buffer:;
  constant slot socket-address-sockaddr :: <sockaddr*>,
    required-init-keyword: sockaddr:;
  constant slot socket-address-sockaddr-length :: <integer>,
    required-init-keyword: sockaddr-length:;
end class;

// We never directly reference this
ignore(socket-address-sockaddr-buffer);

define sealed method raw-socket-address-family
    (sockaddr :: <sockaddr*>)
 => (family :: <integer>)
  // We're naughty here and just cast to <sockaddr-in*> because the family
  // is at the same offset within the structure for all sockaddr structs.
  let sa = pointer-cast(<sockaddr-in*>, sockaddr);
  sockaddr-in$sin-family(sa)
end;

define sealed method socket-address-family
    (socket-address :: <socket-address>)
 => (family :: <integer>)
  raw-socket-address-family(socket-address-sockaddr(socket-address))
end;

define sealed generic socket-address-port
    (socket-address :: <socket-address>)
 => (port :: false-or(<integer>));

define sealed generic socket-address-internet-address
    (socket-address :: <socket-address>)
 => (internet-address);

define sealed class <socket-inet-address> (<socket-address>)
end class;

define sealed method socket-address-port
    (socket-address :: <socket-inet-address>)
 => (port :: false-or(<integer>))
  let s* = pointer-cast(<sockaddr-in*>, socket-address-sockaddr(socket-address));
  sockaddr-in$sin-port(s*)
end method socket-address-port;

define sealed method socket-address-internet-address
    (sa :: <socket-inet-address>)
 => (internet-address :: <string>)
  let sa = pointer-cast(<sockaddr-in*>, sa.socket-address-sockaddr);
  let ia = sockaddr-in$sin-addr(sa);
  let buf = make(<byte-vector>, size: $INET-ADDRSTRLEN,
                 fill: as(<integer>, '\0'));
  with-C-string(ip-address = buf)
    %inet-ntop($AF-INET, ia, ip-address, $INET-ADDRSTRLEN);
    as(<byte-string>, ip-address)
  end with-C-string
end method socket-address-internet-address;

define sealed class <socket-inet6-address> (<socket-address>)
end class;

define sealed method socket-address-internet-address
    (sa :: <socket-inet6-address>)
 => (internet-address :: <string>)
  let sa = pointer-cast(<sockaddr-in6*>, sa.socket-address-sockaddr);
  let ia = sockaddr-in6$sin6-addr(sa);
  let buf = make(<byte-vector>, size: $INET6-ADDRSTRLEN,
                 fill: as(<integer>, '\0'));
  with-C-string(ip-address = buf)
    %inet-ntop($AF-INET6, ia, ip-address, $INET6-ADDRSTRLEN);
    as(<byte-string>, ip-address)
  end with-C-string
end method socket-address-internet-address;

define sealed method socket-address-port
    (socket-address :: <socket-inet6-address>)
 => (port :: false-or(<integer>))
  let s* = pointer-cast(<sockaddr-in6*>, socket-address-sockaddr(socket-address));
  sockaddr-in6$sin6-port(s*)
end method socket-address-port;

define sealed class <socket-unknown-address> (<socket-address>)
end class;

define sealed method socket-address-port
    (socket-address :: <socket-unknown-address>)
 => (port :: false-or(<integer>))
  #f
end method socket-address-port;

define sealed method make
    (class == <socket-address>,
     #rest init-keywords,
     #key sockaddr :: <sockaddr*>,
          sockaddr-length :: <integer>,
     #all-keys)
 => (address :: <socket-address>)
  let family = raw-socket-address-family(sockaddr);
  let sockaddr-class
    = select (family)
        $AF-INET => <socket-inet-address>;
        $AF-INET6 => <socket-inet6-address>;
        otherwise => <socket-unknown-address>;
      end select;
  let buf = make(<byte-vector>, size: sockaddr-length);
  let buf-sockaddr = make(<sockaddr*>, address: byte-storage-address(buf));
  copy-bytes!(buf-sockaddr, sockaddr, buf.size);
  make(sockaddr-class,
       buffer: buf,
       sockaddr: buf-sockaddr,
       sockaddr-length: sockaddr-length)
end method make;
