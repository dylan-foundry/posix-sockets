Module: dylan-user

define module posix-sockets
  use common-dylan;
  use c-ffi;

  use %posix-sockets, export: {
    $AF-INET,
    $AF-INET6,
    $AF-UNIX,
    $AF-UNSPEC,
    $AI-ALL,
    $AI-CANONNAME,
    $AI-NUMERICHOST,
    $AI-NUMERICSERV,
    $AI-PASSIVE,
    $AI-V4MAPPED,
    $INET-ADDRSTRLEN,
    $INET6-ADDRSTRLEN,
    $IPPROTO-TCP,
    $NI-DGRAM,
    $NI-MAXHOST,
    $NI-MAXSERV,
    $NI-NAMEREQD,
    $NI-NOFQDN,
    $NI-NUMERICHOST,
    $NI-NUMERICSERV,
    $PF-INET,
    $PF-INET6,
    $PF-UNSPEC,
    $SHUT-RD,
    $SHUT-RDWR,
    $SHUT-WR,
    $SO-DEBUG,
    $SO-LINGER,
    $SO-RCVBUF,
    $SO-RCVTIMEO,
    $SO-REUSEADDR,
    $SO-SNDBUF,
    $SO-SNDTIMEO,
    $SOCK-DGRAM,
    $SOCK-RAW,
    $SOCK-STREAM,
    $SOL-SOCKET,
    $TCP-NODELAY
  };

  export <address-info>,
         address-info-family,
         address-info-socket-type,
         address-info-protocol,
         address-info-socket-address,
         address-info-canonical-name;

  export <socket-address>,
         socket-address-family,
         socket-address-port;

  export <socket>,
         <bound-socket>,
         <server-socket>,
         socket-file-descriptor,
         socket,
         bind,
         listen,
         accept,
         connect,
         close-socket,
         shutdown-socket;
end module posix-sockets;
