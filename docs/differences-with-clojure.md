(This document was built using the
[one from ClojureScript](https://clojurescript.org/about/differences)
as a guide).

## Rationale

Erlang is a great language for building safe, reliable and scalable
systems. It provides immutable, persistent data structures out of the
box and its concurrency semantics are unequalled by any other
language.

Clojure is a Lisp and as such comes with all the goodies Lisps
provide. Apart from these Clojure also introduces powerful
abstractions such as protocols, multimethods and seqs, to name a few.

Clojure was built to simplify the development of concurrent programs
and some of its concurrency abstractions could be adapted to Erlang.
It is fair to say that combining the power of the Erlang VM with the
expressiveness of Clojure could provide an interesting, useful result
to make the lives of many programmers simpler and make the world a
happier place.

## State and Identity

The Erlang VM implements the actor model, which means *identity* is
generally bound to a process which maintains an internal *state*. This
doesn't mean that the Clojure identity model can't be implemented, but
since the platform favors the actor model, it will always be more
efficient using it than the Clojure model.

## clojure.spec

Not implemented (yet).

## Dynamic Development

There is a REPL available just like Clojure's.

## Functional Programming

Since the Erlang VM already includes native immutable data structures,
Clojerl includes most of the same immutable data structures present in
Clojure. Some of them are implemented based on other immutable data
structures (e.g. sorted sets).

## Lisp

Same as in Clojure.

## Runtime Polymorphism

Protocols and multimethods are available as in Clojure. Everything is
implemented in terms of protocols, there are no interfaces. `proxy` is
not supported.

## Concurrent Programming

TBD

## Hosted on the JVM

Hosted on the Erlang VM.

## Getting Started

[Getting started][getting-started].

## The Reader

- Numbers
    - All integer numbers are mapped to Erlang's representation, which
      are arbitrary precision integers.
    - Numbers with a decimal part are mapped to Erlang's representation
      of floating point numbers.
    - Ratio and BigDecimal are not supported.
- Characters are represented as single-character strings.
- `nil` is currently mapped to the `:undefined` keyword. This is
  because `:undefined` is generally used in Erlang to specify
  'nothing/no-value'.
- `true` and `false` are equivalent to `:true` and `:false`
  respectively.
- Lists, Vectors, Maps and Sets are the same as in Clojure. There is
  no support yet for the [Map namespace syntax][map-ns-syntax].
- Macro characters
    - Because there is no character type in Erlang, `\` produces a
      single-character string.

## The REPL and main

- See [Getting started][getting-started] for instructions on the
  Clojerl REPL.
- The `bin/clojerl` and `bin/clje` scripts can be used the same
  as `bin/clojure` and `bin/clj`.

## Evaluation

- Clojerl has the same evaluation rules as Clojure.

## Special Forms

The following Clojerl special forms are identical to their
Clojure cousins: `if`, `do`, `let`, `letfn`, `quote` and `loop`.

- `fn`
    - Compile to an Erlang function and therefore can't have any
      metadata.
- `recur`
    - `recur` is compiled to an actual recursive call that is only
      allowed in tail position, since the Erlang VM implements tail call
      optimization.
- `def`
    - When the init expression is a `fn`, `def` produces one or more
      Erlang functions, depending on the arities specified in the `fn`
      declaration.
    - When not an `fn`, the init expression (**which is evaluated at
      compile-time**) *must* return a constant literal, otherwise it's a
      compile-time error.
- `throw`
    - There is no error type in Erlang, any value can be thrown.
- `try..catch..finally`
    - An exception in Erlang consists of three things: the class of the
      exception (`throw`, `error` or `exit`), the exit reason and the
      stack-trace. There is no specific type for exceptions.
    - The spec for the `catch` clause is `(catch error-type error &
      body)`, where `error-type` is one of the keywords `:throw`,
      `:error`, `:exit` or `_`. The last one will catch all the error
      types.
- `var`
    - Vars are not reified as in Clojure, they are more similar to what
      ClojureScript does, which returns compile time information about
      the var, and during runtime the information available is static
      (i.e. can't be modified without recompiling).
    - Vars can't have watches or a validator.
    - It's not possible to change the root binding of a Var.
- `monitor-enter`, `monitor-exit`, and `locking` are not supported.

## Macros

Macros in Clojerl work the same as in Clojure.

## Other Useful Functions and Macros

- Regex support is the one provided by the `re` Erlang module.

## Data Structures

- `nil`'s type is `clojerl.Nil`. It is equivalent to `:undefined`.
- Numbers
    - All integers are Erlang integers (arbitrary precision).
- Strings are UTF-8 encoded Erlang binaries.
- Characters are single-char strings.
- Collections
    - Clojerl uses the same hash computations as Clojure.
    - When possible a native Erlang data structure is used (i.e. map,
      list, tuple) in the underlying implementation.
        - List uses an Erlang list.
        - Vector uses `clj_vector`, which is an Erlang implementation
          of Clojure's persistent vector.
        - Map uses an Erlang map.
        - Sorted Maps use Robert Virding's implementation of red-black
          trees.
        - Sets use Erlang maps.
        - StructMap will not be implemented since "most uses of
          StructMaps would now be better served by records".
        - ArrayMap's closest relative in Clojerl is TupleMap.
- Literal Erlang collections can be included in code by using the
  `#erl` dispatch reader macro:
    - `#erl ()` Erlang lists
    - `#erl []` Erlang tuples
    - `#erl {}` Erlang maps

## Datatypes

- `defprotocol` and `deftype`, `extend-type`, `extend-protocol` work as in Clojure.
- Protocols are not reified as in Clojure, there are no runtime protocol objects.
- Some reflective capabilities (`satisfies?`) work as in Clojure.
- `extend` is not implemented.
- `reify` is not implemented.

## Sequences

- Seqs are the same as in Clojure.

## Transient Data Structures

Transients are currently not implemeted.

## Transducers

Stateful transducers are currently not implemeted.

## Multimethods and Hierarchies

- Multimethods works as in Clojure.
- Hierarchies are not implemented.

## Metadata

Works as in Clojure for all the same data structures, except for
`fn`s.

Anonymous functions are compiled into Erlang closures, for which there
is no way to bolt arbitrary information.

## Namespaces

Namespaces are compiled into Erlang modules. They are available at
runtime for inspection, as in Clojure.

## Libs

Existing Clojure libs will have to conform to the Clojerl subset
in order to work in Clojerl.

## Vars and the Global Environment

- `def`, `binding` and `set!` work as in Clojure
    - `def` yields the Var itself as in Clojure.
    - Root bindings can't be modified (e.g. with `alter-var-root`
      or `with-redefs`).
    - Vars can't have watches or a validator.
- Atom and Agent implementations are experimental.
- Refs are not currently implemented.

## Refs and Transactions

Refs and Transactions are not implemented.

## Agents

Agent implementation is experimental.

## Atoms

Atom implementation is experimental.

## Reducers

Reducers are not implemented.

## Host Interop

- Member access
    - All types in Clojerl have an implementation module with the same
      name as the type. "Member access" is translated to a function call
      to the specified function in the type's module where the first
      argument is the value.
- Type Hinting
    - There are no primitive types in Erlang so there is no use for
    `int`, `ints`, etc.
    - Type hints are used to resolve the target's type at compile-time
      and avoid having to figure out at run-time.
- Calling Clojerl from Erlang
    - Since Clojerl namespaces are Erlang modules, calling a function
      from the `clojure.core` module is as simple as:

      ```
      'clojure.core':inc(1).
      %%= 2
      ```

## Ahead-of-time Compilation and Class Generation

- Each namespace is generally compiled into one Erlang module, except
  when `defrecord`, `deftype` or one of the `extend-*` functions is
  used.
- `gen-class`, `gen-interface`, etc. are unnecessary and unimplemented in
  Clojerl.

## Other Included Libraries

- `clojure.erlang.io` is an attempt to provide the same polymorphic
  I/O utility functions for Erlang.
- `clojure.erlang.erldocs` (Missing)
- `clojure.erlang.shell` (Missing)
- `clojure.repl`
- `clojure.set`
- `clojure.string`
- `clojure.test`
- `clojure.walk`
- `clojure.xml`
- `clojure.zip`
- `clojure.core.reducers` (Missing)
- `clojure.spec` (Missing)
- `clojure.pprint`

[getting-started]: https://github.com/jfacorro/clojerl#getting-started
[map-ns-syntax]: https://github.com/clojerl/clojerl/issues/325
