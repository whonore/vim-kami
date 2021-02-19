" Vim syntax file
" Language: Kami (Coq DSL)
" Author: Wolf Honore

" Require Coq syntax to be loaded already
if !exists('b:current_syntax') || b:current_syntax !=# 'coq'
  finish
endif

syn cluster kamiTerm    contains=kamiReg,kamiRule,kamiMethod
syn cluster kamiExpr    contains=kamiType,kamiArray,kamiStruct,kamiSpecial,kamiLet,kamiRead,kamiWrite,kamiCall,kamiReturn,kamiReturnv,kamiIf,kamiNondet,kamiSys,kamiConcat
syn cluster coqTerm     add=kamiModule,@kamiExpr

syn keyword kamiSpecial contained Default Void

" A name in quotes optionally prefixed by some combination of @ and ^
syn region kamiStrIdent contained contains=coqString matchgroup=coqIdent start=+[@^]*"+ end=+"+

" Top-Level

" Modules
syn region kamiModule       contained contains=kamiModuleBody matchgroup=kamiKwd start="\<\%(MODULE\|MODULE_WF\|MOD_WF\)\>" matchgroup=kamiPunc end="}" keepend
syn region kamiModuleBody   contained contains=@kamiTerm matchgroup=kamiPunc start="{" end="}"

" Registers
syn region kamiReg      contained contains=kamiStrIdent,kamiRegType,kamiRegBody matchgroup=kamiKwd start="\<Register[NU]\?\>" matchgroup=kamiPunc end="\<with\>" end="}"me=e-1 keepend extend
syn region kamiRegType  contained contains=@coqTerm matchgroup=kamiPunc start=":" end="<-"me=e-2
syn region kamiRegBody  contained contains=@coqTerm matchgroup=kamiPunc start="<-" end="\<with\>" end="}"

" Rules
syn region kamiRule     contained contains=kamiStrIdent,kamiRuleBody matchgroup=kamiKwd start="\<Rule\>" matchgroup=kamiPunc end="\<with\>" end="}"me=e-1 keepend extend
syn region kamiRuleBody contained contains=@kamiExpr matchgroup=kamiPunc start=":=" end="\<with\>" end="}"

" Methods
syn region kamiMethod     contained contains=kamiStrIdent,kamiCallArg,kamiMethodType,kamiMethodBody matchgroup=kamiKwd start="\<Method\>" matchgroup=kamiPunc end="\<with\>" end="}"me=e-1 keepend extend
syn region kamiMethodType contained contains=@coqTerm matchgroup=kamiPunc start=":" end=":="me=e-2
syn region kamiMethodBody contained contains=@kamiExpr matchgroup=kamiPunc start=":=" end="\<with\>" end="}"

" Types

syn keyword kamiType    contained Bool Bit Array Struct

" Arrays
syn region kamiArray        contained contains=kamiArrayBody matchgroup=kamiType start="\<ARRAY\%(_CONST\)\?\>" matchgroup=kamiPunc end="}" keepend extend
syn region kamiArrayBody    contained contains=kamiArrayEntry matchgroup=kamiPunc start="{" end="}"
syn region kamiArrayEntry   contained contains=@coqTerm matchgroup=kamiPunc start="{" start=";" end=";" end="}"

" Structs
syn region kamiStruct           contained contains=kamiStructBody matchgroup=kamiType start="\<STRUCT\%(_\%(TYPE\|CONST\)\)\?\>" matchgroup=kamiPunc end="}" keepend extend
syn region kamiStructBody       contained contains=kamiStructField matchgroup=kamiPunc start="{" end="}"
syn region kamiStructField      contained contains=kamiStrIdent,kamiStructFieldBody matchgroup=NONE start=+"+ matchgroup=kamiPunc end=";" end="}"
syn region kamiStructFieldBody  contained contains=@coqTerm matchgroup=kamiPunc start="::=\?" end=";" end="}"

" Expressions/Actions

" Let
syn region kamiLet      contained contains=coqIdent,kamiLetType,kamiLetBody matchgroup=kamiExpr start="\<LET[ACEN]\?\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend
syn region kamiLetType  contained contains=@coqTerm matchgroup=kamiPunc start=":" end="<-"me=e-2
syn region kamiLetBody  contained contains=@coqTerm matchgroup=kamiPunc start="<-" end=";" end="\<with\>" end="}"

" Read
syn region kamiRead     contained contains=coqIdent,kamiReadType,kamiReadBody matchgroup=kamiExpr start="\<ReadN\?\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend
syn region kamiReadType contained contains=@coqTerm matchgroup=kamiPunc start=":" end="<-"me=e-2
syn region kamiReadBody contained contains=kamiStrIdent matchgroup=kamiPunc start="<-" end=";" end="\<with\>" end="}"

" Write
syn region kamiWrite        contained contains=kamiStrIdent,kamiWriteType,kamiWriteBody matchgroup=kamiExpr start="\<WriteN\?\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend
syn region kamiWriteType    contained contains=@coqTerm matchgroup=kamiPunc start=":" end="<-"me=e-2
syn region kamiWriteBody    contained contains=@coqTerm matchgroup=kamiPunc start="<-" end=";" end="\<with\>" end="}"

" Call
syn region kamiCall     contained contains=coqIdent,kamiCallType,kamiCallBody matchgroup=kamiExpr start="\<Call\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend
syn region kamiCallType contained contains=@coqTerm matchgroup=kamiPunc start=":" end="<-"
syn region kamiCallBody contained contains=kamiStrIdent,kamiCallArg start=+[@^]*"+ end=";" end="\<with\>" end="}"
syn region kamiCallArg  contained contains=@coqTerm matchgroup=kamiPunc start="(" end=")"

" Return
syn region kamiReturn   contained contains=@coqTerm matchgroup=kamiExpr start="\<RetE\?\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend
syn keyword kamiReturnv contained Retv

" If
syn region kamiIf       contained contains=@coqTerm,kamiIfBind matchgroup=kamiExpr start="\<I[fF]E\?\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend
syn region kamiIfBind   contained contains=coqIdent matchgroup=kamiPunc start="\<as\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend

" Non-determinism
syn region kamiNondet       contained contains=coqIdent,kamiNondetType matchgroup=kamiExpr start="\<NondetN\?\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend
syn region kamiNondetType   contained contains=@coqTerm matchgroup=kamiPunc start=":" end=";" end="\<with\>" end="}"

" System
syn region kamiSys  contained contains=@coqTerm matchgroup=kamiExpr start="\<SystemE\?\>" matchgroup=kamiPunc end=";" end="\<with\>" end="}" keepend

" Concat (have to catch so '>}' isn't treated as the end of the module)
syn region kamiConcat   contained contains=@coqTerm matchgroup=kamiPunc start="{<" end=">}" keepend extend

hi link kamiSpecial     Special

hi link kamiStrIdent    coqIdent

hi link kamiPunc        coqTermPunctuation

hi link kamiKwd         Keyword

hi link kamiType        Type

hi link kamiExpr        coqKwd
hi link kamiReturnv     kamiExpr

let b:current_syntax = 'coq-kami'
