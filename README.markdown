Remit2
======

This API provides access to the Amazon Flexible Payment Service (FPS), using the
2008-09-17 version of the API and Signature Version 2.

Remit2 is forked from the original Remit library written by Tyler Hunt, which was
built for the 2007-08-01 FPS API version and Signature Version 1. Due to serious
incompatibilities between the two API versions, I decided to fork the library
and give up backward compatibility with the older API version.

Working with Remit2 should very closely resemble working with Remit, with the exception
of the changed API parameter and function names. However, due to these same changes, it's
almost never the case that Remit2 can be dropped in place of Remit without some changes
to the client code. For example, the *Amount* parameter in the *Pay* operation has
changed, and nearly every FPS client application will need to use *Pay*.

**WARNING** - This gem should be considered very volatile and incomplete. I (Micah)
am not looking to write a full wrapper around the FPS API. My only goal is to get it
working for my needs. Therefore, many of the functions/API calls will be broken.
Patches are welcome if you want to make additions.

I have explicitly marked some files as "# Updated for API Version 2008-09-17". If
you don't see this near the top of the file, assume that it doesn't work!

Copyright (c) 2010 Micah Wedemeyer, released under the MIT license
