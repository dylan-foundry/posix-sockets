module: dylan-user

define library posix-sockets-test-suite-app
  use testworks;
  use posix-sockets-test-suite;
end library;

define module posix-sockets-test-suite-app
  use testworks;
  use posix-sockets-test-suite;
end module;
