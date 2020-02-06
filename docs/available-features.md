# Available Features

We provide here a list of the features that are already implemented and
available, the ones that are still missing and those that can't or won't be
supported.

For a detailed list on the differences between Clojerl and Clojure please check
[here](../differences-with-clojure).

## Implemented

- **Special Forms**
    - Clojure: `def`, `do`, `fn*`, `if`, `quote`, `let*`, `letfn*`, `loop*`,
      `recur`, `case*`, `throw`, `try`, `var`, `import*`, `new`, `deftype*`,
      `defprotocol*`, `extend-type*`, `.`
    - Erlang: `receive*`, `erl-binary*`, `erl-list*`, `erl-alias*`,
      `erl-on-load*`
- **Multi-method**
- **Reader**
    - Namespaced maps
- **Data Structures**
    - Clojure
        - ChunkedCons
        - Cons
        - LazySeq
        - List
        - Map
        - Range
        - Set
        - SortedSet
        - SortedMap
        - Vector
        - Vector.ChunkedSeq
    - Erlang
        - Map
        - List
        - Tuple
- **Concurrency**
    - Atom (experimental)
    - Agent (experimental)
    - Delay (experimental)
    - Future
    - Promise
    - CountDownLatch (experimental)
- **Clojure Libraries**
    - `clojure.core`
    - `clojure.core.server`
    - `clojure.data`
    - `clojure.edn`
    - `clojure.erlang.io`
    - `clojure.instant`
    - `clojure.repl`
    - `clojure.main`
    - `clojure.pprint`
    - `clojure.set`
    - `clojure.stacktrace`
    - `clojure.string`
    - `clojure.template`
    - `clojure.test`
    - `clojure.uuid`
    - `clojure.walk`
    - `clojure.xml`
    - `clojure.zip`
- **Transducers**

## Not Implemented

- **Multi-method**
    - Hierarchies
- **Concurrency**
    - Ref (no plans for implementation)
- **Clojure Libraries**
    - `clojure.erlang.erldocs`
    - `clojure.erlang.shell`
    - `clojure.core.reducers`
    - `clojure.spec`

## Unsupported

- **Concurrency**
    - Volatile
- **Data Structures**
    - Transient collections
    - StructMaps (see why [here][structmaps])
- **Math**
    - unchecked

[structmaps]: https://clojure.org/reference/data_structures#StructMaps
