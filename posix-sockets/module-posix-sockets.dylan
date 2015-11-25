Module: dylan-user

define module posix-sockets
  use common-dylan;
  use c-ffi;
  use %posix-sockets;

  export <address-info>,
         address-info-family,
         address-info-socket-type,
         address-info-protocol,
         address-info-socket-address,
         address-info-canonical-name;

  export <socket-address>,
         socket-address-family,
         socket-address-port,
         socket-address-internet-address;

  export <socket>,
         socket-file-descriptor,
         socket,
         bind,
         listen,
         accept,
         connect,
         close-socket,
         shutdown-socket;
end module posix-sockets;
