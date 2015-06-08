# Ocamlbuild plugin for atdgen

This plugin is simply an extraction of the original plugin from Hcarty's
[ocamlbuild plugins repository](https://github.com/hcarty/ocamlbuild-plugins/) and originally
authored by Daniel Weil. The point of this extraction is to make the plugin
available through opam and findlib to make it easier to use.

# Usage

After installing the plugin (from opam or otherwise). You should edit your
`myocamlbuild.ml` to look like:

```ocaml
let _ = Ocamlbuild_plugin.dispatch Ocamlbuild_atdgen.dispatcher
```

Then you must invoke ocamlbuild like this:

```
$ ocamlbuild -use-ocamlfind -plugin-tag "package(ocamlbuild_atdgen)" target.native
```

There's also a complete example project in `example/`
