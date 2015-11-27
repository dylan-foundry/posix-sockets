Module: dylan-user

define library posix-sockets
  use dylan;
  use common-dylan;
  use c-ffi;
  use io;

  export posix-sockets;
end library posix-sockets;
