module: posix-sockets-test-suite
synopsis: Test suite for the posix-sockets library.

define test example-test ()
  assert-true(#t);
end test example-test;

define suite posix-sockets-test-suite ()
  test example-test;
end suite;
