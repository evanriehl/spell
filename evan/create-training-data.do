#delimit;
clear; set matsize 5000; set more off; set type double;
global tmp "/data/colomb/temp";
global sp  "/data/spell/evan";

foreach ds in icfes students2 {;
 use $tmp/`ds', clear; global l=upper(substr("`ds'",1,1));
 keep    documento fullname;
 bysort  documento fullname: keep if _n==1;
 drop if documento<1000000 | documento==.; drop if fullname=="";
 by      documento: gen dup=_N; tab dup; keep if dup<=2; drop dup;
 by      documento: gen j=_n; rename fullname ${l}name;
 reshape wide ${l}name, i(documento) j(j);
 save $sp/tomerge$l, replace;
};

use $sp/tomergeI; merge documento using $sp/tomergeS; tab _merge; keep if _merge==3; drop _merge;
reshape long Iname, i(documento      ) j(j); drop if Iname==""; drop j; rename Iname name1;
reshape long Sname, i(documento name1) j(j); drop if Sname==""; drop j; rename Sname name2;
drop documento; gen equal=name1==name2; sort name1 name2;
compress; outsheet using $sp/names.csv, comma nonames noquote replace;

foreach ds in tomergeI tomergeS {; erase $sp/`ds'.dta;};
