module: posix-sockets-test-suite-app

define suite all-posix-sockets-test-suites ()
  suite posix-sockets-test-suite;
end;

run-test-application(all-posix-sockets-test-suites);
