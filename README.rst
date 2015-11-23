posix-sockets
=============

This is a new socket binding library for `Open Dylan`_. It may
be made to work with `Mindy`_ in the future.

This library provides a wrapper around the newer POSIX sockets
APIs rather than the older BSD sockets APIs. It supports both
IPv4 and IPv6. It provides a low level binding in the
`posix-sockets` library.

This is still in the early stages of development. Contributions
are welcome, but please talk with us first.

Building posix-sockets
----------------------

You will need a current version of Open Dylan and `melange`_,
our bindings generator. The ``melange`` binary needs to be
on the ``PATH``.

Then::

   # Run melange and generate the C-FFI bindings.
   (cd posix-sockets; make)
   # Build our library
   dylan-compiler -build posix-sockets

Using posix-sockets
-------------------

For now, since this requires running ``melange`` to generate
the bindings, there will be work involved in actually using
this library from outside of this repository. This will be
addressed as this library evolves.

.. _Open Dylan: http://opendylan.org/
.. _Mindy: https://github.com/project-mindy/mindy/
.. _melange: https://github.com/dylan-lang/melange/
