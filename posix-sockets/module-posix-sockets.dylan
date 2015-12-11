Module: dylan-user

define module posix-sockets
  use common-dylan;
  use c-ffi;
  use dylan-extensions;
  use operating-system;
  use print;
  use streams;

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
    $MSG-OOB,
    $MSG-PEEK,
    $MSG-DONTROUTE,
    $MSG-EOR,
    $MSG-TRUNC,
    $MSG-CTRUNC,
    $MSG-WAITALL,
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
    $SO-KEEPALIVE,
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
    $TCP-KEEPCNT,
    $TCP-KEEPINTVL,
    $TCP-NODELAY
  };

  export <address-info>,
         address-info-family,
         address-info-socket-type,
         address-info-protocol,
         address-info-socket-address,
         address-info-canonical-name,
         get-address-info;

  export <socket-address>,
         socket-address-family,
         socket-address-port;

  export <socket>,
         <unbound-socket>,
         <bound-socket>,
         <server-socket>,
         socket-file-descriptor,
         socket-address;

  export socket,
         bind,
         listen,
         accept,
         connect,
         recv,
         send,
         shutdown-socket;

  export <ready-socket>,
         local-socket-address,
         peer-socket-address;
end module posix-sockets;
