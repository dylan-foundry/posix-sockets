Module: %posix-sockets
Synopsis: Auto-generated bindings for the POSIX sockets API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define interface
  #include {
      "sys/socket.h",
      "netinet/in.h",
      "netinet/tcp.h",
      "sys/un.h",
      "arpa/inet.h",
      "netdb.h",
      "unistd.h",
      "sys/select.h"
    },
    inline-functions: inline,
    equate: {"char *" => <C-string>},
    import: {
      "accept",
      "bind",
      "close",
      "connect",
      "freeaddrinfo",
      "gai_strerror",
      "getaddrinfo",
      "gethostname",
      "getnameinfo",
      "getpeername",
      "getsockopt",
      "inet_ntop",
      "inet_pton",
      "listen",
      "recv",
      "recvfrom",
      "select",
      "send",
      "sendto",
      "setsockopt",
      "shutdown",
      "socket",
      "struct sockaddr",
      "struct sockaddr_in",
      "struct sockaddr_in6"
    },
    import: {
      "AF_INET",
      "AF_INET6",
      "AF_UNIX",
      "AF_UNSPEC",
      "AI_ALL",
      "AI_CANONNAME",
      "AI_NUMERICHOST",
      "AI_NUMERICSERV",
      "AI_PASSIVE",
      "AI_V4MAPPED",
      "INET_ADDRSTRLEN",
      "INET6_ADDRSTRLEN",
      "IPPROTO_TCP",
      "NI_DGRAM",
      "NI_MAXHOST",
      "NI_MAXSERV",
      "NI_NAMEREQD",
      "NI_NOFQDN",
      "NI_NUMERICHOST",
      "NI_NUMERICSERV",
      "PF_INET",
      "PF_INET6",
      "PF_UNSPEC",
      "SO_DEBUG",
      "SO_LINGER",
      "SO_RCVBUF",
      "SO_RCVTIMEO",
      "SO_REUSEADDR",
      "SO_SNDBUF",
      "SO_SNDTIMEO",
      "SOCK_DGRAM",
      "SOCK_RAW",
      "SOCK_STREAM",
      "SOL_SOCKET",
      "SHUT_RD",
      "SHUT_RDWR",
      "SHUT_WR",
      "TCP_NODELAY"
    };

  function "accept" => %accept;
  function "bind" => %bind;
  function "close" => %close;
  function "connect" => %connect;
  function "freeaddrinfo" => %freeaddrinfo;
  function "gai_strerror" => %gai-strerror;
  function "getaddrinfo" => %getaddrinfo;
  function "gethostname" => %gethostname;
  function "getnameinfo" => %getnameinfo;
  function "getpeername" => %getpeername;
  function "getsockopt" => %getsockopt;
  function "inet_ntop" => %inet-ntop;
  function "inet_pton" => %inet-pton;
  function "listen" => %listen;
  function "recv" => %recv;
  function "recvfrom" => %recvfrom;
  function "select" => %select;
  function "send" => %send;
  function "sendto" => %sendto;
  function "setsockopt" => %setsockopt;
  function "socket" => %socket;
  function "shutdown" => %shutdown;
end interface;
