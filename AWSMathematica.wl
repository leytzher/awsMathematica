(* ::Package:: *)

(* ::Input:: *)
(*BeginPackage["AWSMathematica`"]*)
(**)
(*hmac`::usage = "hmac[String,Key,md5] returns encription in HMAC SHA256"*)
(**)
(**)
(*Begin["`Private`"]*)
(**)
(*(*Pad the string s with x on the right/left so it has length n.*)strpadr[s_,n_,x_]:=StringJoin@PadRight[Characters[s],n,x]*)
(*strpadl[s_,n_,x_]:=StringJoin@PadLeft[Characters[s],n,x]*)
(**)
(*(*hex representation;optionally pad to length n with zeros*)*)
(*hex[x_,n_:Null]:=If[n===Null,Identity,strpadl[#,n,"0"]&]@IntegerString[x,16]*)
(**)
(*(*parse hex representation (return an integer)*)*)
(*unhex[x_]:=FromDigits[x,16]*)
(**)
(*(*Concatenate all the arguments as strings (if they're not already).*)*)
(*cat=StringJoin@@(ToString/@{##})&;*)
(**)
(*(*Takes a string like "xy" and returns the hex representation (also a string,twice as long) of the bytes (ascii codes).*)*)
(*tobytes[s_]:=cat@@(hex[#,2]&/@ToCharacterCode[s])*)
(**)
(*(*Takes a length n string like "0a10" and returns a length n/2 string where in this example the first character is whatever has ascii code 10 ("a" in hex) and the second is whatever has ascii code 16 ("10" in hex).*)*)
(*frombytes[hs_]:=FromCharacterCode[unhex/@cat@@@Partition[Characters[hs],2]]*)
(**)
(*(*Bitwise-xor of two integers given in hex.*)*)
(*hexbitxor[a_String,b_String]:=hex@BitXor[unhex@a,unhex@b]*)
(**)
(*(*Repeat the string s,n times.*)*)
(*strrpt[s_,n_]:=cat@@ConstantArray[s,n]*)
(**)
(*(*Byte length of a hex string is half the string length.*)*)
(*bytelen[s_]:=Ceiling[StringLength[s]/2]*)
(*(*FileHash is the only way to hash data given as a string in Mma.*)hash[s_String,h_:"SHA"]:=Module[{stream=StringToStream[s],result},result=FileHash[stream,h];*)
(*Close[stream];*)
(*hex@result];*)
(*sha1[s_]:=hash[s]*)
(*md5[s_]:=hash[s,"SHA256"]*)
(**)
(*(*Return the hmac digest using hash function h for string s with key k.*)hmac[s_,k_,h_:sha1]:=Module[{b,key,ipad,opad},*)
(*b=64;*)
(*(*block size for both md5 and sha1*)key=tobytes[k];*)
(*key=If[bytelen[key]>b,h[frombytes@key],key];*)
(*key=strpadr[key,2 b,"0"];*)
(*ipad=hexbitxor[strrpt["36",b],key];*)
(*opad=hexbitxor[strrpt["5c",b],key];*)
(*h[frombytes[opad<>h[frombytes[ipad<>tobytes@s]]]]]*)
(**)
(*End[]*)
(*EndPackage[]*)
