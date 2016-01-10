Module: echo-server
Synopsis: A simple echo-server using the posix sockets bindings.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define constant $BACKLOG = 8;

define function main (name :: <string>, arguments :: <vector>)
  let addresses = get-address-info("localhost", "2345", socktype-hint: $SOCK-STREAM);
  let ai = addresses[0];
  let sock = socket(ai.address-info-family, ai.address-info-socket-type, ai.address-info-protocol);
  let sock = bind(sock, ai.address-info-socket-address);
  let sock = listen(sock, $BACKLOG);
  let client-sock = accept(sock);
  let buffer = make(<byte-string>, size: 100);
  while (#t)
    let byte-count = recv(client-sock, buffer);
    send(client-sock, buffer, end: byte-count);
  end;
end function main;

main(application-name(), application-arguments());
