Module: dylan-user

define library posix-sockets
  use dylan;
  use common-dylan;
  use c-ffi;
  use io;
  use system;

  export posix-sockets;
end library posix-sockets;
