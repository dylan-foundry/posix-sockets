Module: dylan-user

define library echo-server
  use common-dylan;
  use posix-sockets;

  export echo-server;
end library echo-server;

define module echo-server
  use common-dylan;
  use posix-sockets;
end module echo-server;
