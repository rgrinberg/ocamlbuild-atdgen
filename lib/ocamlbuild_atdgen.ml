open Ocamlbuild_plugin

let () = Options.use_ocamlfind := true

let atdgen = "atdgen"

let tag_atdgen env patterns =
  patterns
  |> List.iter (fun p ->
    ["package(atdgen)"]
    |> Tags.of_list
    |> Tags.elements
    |> tag_file (env p)
  )

let init () =
  rule "atdgen: .atd -> _t.ml*"
    ~prods:["%_t.ml";"%_t.mli"]
    ~dep:"%.atd"
    (begin fun env build ->
       tag_atdgen env ["%_t.ml";"%_t.mli"];
       Cmd (S [A atdgen; A "-t"; P (env "%.atd")]);
     end) ;
  rule "atdgen: .atd -> _j.ml*"
    ~prods:["%_j.ml";"%_j.mli";]
    ~dep:"%.atd"
    (begin fun env build ->
       tag_atdgen env ["%_j.ml"; "%_j.mli"];
       Cmd (S [A atdgen; A "-j"; A "-j-std"; P (env "%.atd")]);
     end) ;
  rule "atdgen: .atd -> _v.ml*"
    ~prods:["%_v.ml";"%_v.mli";]
    ~dep:"%.atd"
    (begin fun env build ->
       tag_atdgen env ["%_v.ml";"%_v.mli";];
       Cmd (S [A atdgen; A "-v"; P (env "%.atd")]);
     end)

let dispatcher = function
  | After_rules -> init ()
  | _ -> ()
