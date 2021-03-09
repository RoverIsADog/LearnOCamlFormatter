# LearnOCaml Exercice Formatter

Extremely crude script that removes the need to reformat code when transferring between VSCode and LearnOcaml. For those that prefer to do LearnOcaml exercices in VSCode rather than in the browser.
* Removes the prelude from the code.
* Removes `printf` and any user defined illegal libraries.

Output `pastebin.ml` can be safely copy-pasted in its entirety into LearnOcaml without manual reformatting.

## Usage
Surround prelude with markers "`(* Prelude Boundary *)`" and make sure **any illegal library calls are on their own lines.** i.e. The line they are on can be safely removed.

Run with `./learnocamelize.sh <fileName>.ml` to output formatted code into `pastebin.ml`.

### Example

`myFile.ml`
```ocaml
(* Prelude Boundary *)

let someVar = 123.0;; (* Copy paste prelude here *)
let someFunc x y = x + y;;

(* Prelude Boundary *)

(* My own code *)
let times (x:float) = someVar *. x;;
let myVar = ref 130;;
let myIncrement (x:int ref) = (
    Printf.printf "[DEBUG] Currently incrementing %d" !x;
    someFunc !x 1
);;
myIncrement myVar;;
```
Format with `./learnocamelize.sh myFile.ml`.

`pastebin.ml`
```ocaml
(* My own code *)
let times (x:double) = myVar *. x;;
let myVar = ref 130;;
let myIncrement (x:int ref) = (
    someFunc !x 1
);;
myIncrement myVar;;
```

### To set as default build task.
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Format to LearnOCaml",
            "type": "shell",
            "command": "./learnocamelize.sh ${fileBasename}",
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```
