AinurOS
=======

Next-generation Operating System for Exascale Computing


The current project attemps to provide novel software constructs leading to
better capabilities in exascale infrastructures. The approach followed here
is that of functional programming languages with a radical perspective: apart
from boilerplate code written in assembly, the system is expected to become
self-hosted at all levels. A key requirement to fulfill in exascale infrastruc-
tures is resilience; therefore, care will be exercised to intentionally include
at the operating system level constructs that allow task-to-processor assignment
transparent, as well as removing developers from controlling task-migration in
case of software errors.

It may be amply questionable by the current software tradition to opt for a
fully functional language. Given that technology trends are now able to compen-
sate for any language-bound inefficiencies, and that there exist functional
languages for which efficient translation into machine code is possible, AinurOS
is developed with the underlying philosophy of being closer to mathematics for
scientific developers and more transparent and easy to understand for system
programmers and future maintainers.

The code contained herein is expected to change and impact in the set of tools
used to build it, namely the Clean programming language and its current compile
and development environment. It will be therefore provided as-is, without any
warrant or right that may lead to liabilities. This project must be considered,
as long as it is not stated otherwise, as a personal and academic endeavour.

For further information, please send an email to the following email address.

Santiago Núñez Corrales
snunezcr@gmail.com
