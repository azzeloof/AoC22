val infile = "input.txt" ;

open List;

fun readlist (infile : string) = let 
  val ins = TextIO.openIn infile 
  fun loop ins = 
   case TextIO.inputLine ins of 
      SOME line => line :: loop ins 
    | NONE      => [] 
in 
  loop ins before TextIO.closeIn ins 
end ;

fun score (data : string list, n : int, len : int, total : int) = if n<len then (
    let
        val st = sub(data, n);
        val a = substring(st, 0, 3);
        val first = substring(a, 0, 1);
        val last = substring(a, 1, 2);
        val tt = ref 0
    in
        if first="A" then (
            if last=" Y" then tt := !tt+6 else if last=" X" then tt := !tt+3 else tt := !tt
        ) else if first="B" then (
            if last=" Z" then tt := !tt+6 else if last=" Y" then tt := !tt+3 else tt := !tt
        ) else if first="C" then (
            if last=" X" then tt := !tt+6 else if last=" Z" then tt := !tt+3 else tt := !tt
        ) else (
            tt := !tt
        );
        if last=" X" then tt := !tt+1 else if last=" Y" then tt := !tt+2 else if last=" Z" then tt := !tt+3 else tt := !tt;
        !tt + score(data, n+1, len, total)
    end
    ) else 0


val data = readlist(infile);
val l = length(data);
val a = Int.toString(score(data, 0, l, 0));
print a;