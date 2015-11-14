module: dylan-user

define library posix-sockets-test-suite
  use common-dylan;
  use posix-sockets;
  use testworks;
  use system;

  export posix-sockets-test-suite;
end library;

define module posix-sockets-test-suite
  use common-dylan;
  use posix-sockets;
  use testworks;

  export posix-sockets-test-suite;
end module;
