
/*FUNCTIONS*/



/* 1. substr */

*1. SUBSTR: The substr function EXTRACTS A TEXT(substring) FROM THE CHARACTER VARIABLE, and the length of the new var is same as 
          that of the string, it takes 3 arguments string name, start position and length.*/
DATA A;
SET admit;
new=substr(actlevel,2,2);
run;


*2. SUBSTR ON LEFT: The substr function extracts a text from the character variable, IT COULD ALSO BE USED TO REPLACE 
                  THE VALUE, when it is on the LEFT SIDE it assigns the new values, suppose you need to change the first 
                  two values from 91 to 00, you can assign by putting it to left side;
data a;
x="(91) 9999945454";
substr(x,8,2)="44";
run;
*2a. SUBSTR ON LEFT: You can use the substr function conditionally changing the values;
data a;
set admit;
if substr(actlevel,1,2)="MO" then do;
substr(actlevel,1,6)="median"; *it will throw an error coz of 3rd argument;
end;
run;

data a1; *I want to change it as a "meD" in output----  possible?;
set admit;
if substr(actlevel,1,2)="MO" then do;
substr(actlevel,1,6)="meD"; *we can't change erlier length so not gives max 4 in third argument;
end;
run;
* If the substr creates a new variable then the length of the new variable would be same as that of parent variable;




*3. SUBSTR: counts blanks too * The substr function extracts a text from the character variable, it counts blanks too, 
            trying to get two chars would return just one as blank is counted;

data a;
x='(91) 9999265789';
phone=substr(x,5,2);
run;


*4. SUBSTR no third argument: The substr function extracts a text from the character variable, and if no third argument
                              then it would select the whole string from that point;
data b;
x="(91) 9999945454";
No=substr(x,8);
run;








data a;
set sasuser.admit;
E_Word=substr(actlevel,2,2);
run;
proc print;
run;

data b;
set sasuser.admit;
E_Word=substr(actlevel,2);
run;
proc print;
run;

data c;
set sasuser.admit;
substr(actlevel,2)="9999";
run;
proc print;
run;


*conditionally changing the the value.;
data d;
set sasuser.admit;
if substr(actlevel,1,2)="HI" then do;
substr(actlevel,2,2)="ho";
end;
run;
proc print;
run;



data e;
x='(91) 9999265789'; 
phone=substr(x,5,2); 
run;
proc print data=e;
run;



/*7. The =: as a substr **The =: works as a substr for defined number of bytes, it is just used in the equality 
          condition;*/
data f;
set sasuser.admit;
if actlevel=:"L"; *it tells those whose equql to 'L' gives output;
run;
proc print;
run;





/**** 2. SCAN *******/
*It extract the WORD from the charter variables**;

data g;
a="shelly is a terrier bread dog";
x=scan(a,6," ");
y=scan(a,4," ");
z=scan(a,5," ");
p=scan(a,1," ");
run;
proc print ;
run;


/* 1. SCAN function – delimiter*/
data h;
a="shelly~is~a~terrier~bread~dog";
x=scan(a,4,"~");
y=scan(a,6,"~");
Z=scan(a,5,"~");
run;
proc print;
run;


/* 2. SCAN function – delimiter + blank*/
data j;
a="shelly~ is~ a~ terrier~ bread~ dog";
x=scan(a,4,"~");
y=scan(a,6,"~");
Z=scan(a,5,"~");
run;
proc print;
run;

/*3. imp: SCAN function - delimiter+blank +dlm as first char*/
data j;
a="~shelly~ is~ a~ terrier~ bread~* dog";
x=scan(a,1,"~"); *we only give the delimeter in third argument its automatically pick space as well;
y=scan(a,5,"~");
z=scan(a,6,"~");
p=scan(a,6,"*");
q=scan(a,2,"*");
r=scan(a,6,"~*");
run;
proc print;
run;


/*4. Leading blanks/ Multiple delimiters*/
data k;
a="    shelly     is     terrier bread   ";
x=scan(a,2," ");
y=scan(a,4," ");
z=scan(a,1," ");
run;


data l;
a="####shelly####is####terrier#bread####dog";
x=scan(a,1,"#");
y=scan(a,3,"#");
z=scan(a,4,"#");
run;
proc print;
run;

/*5. Scan from RIGHT*/

data x; 
input @1 name $5. @7 marks; 
datalines;
a b c 20
k d   15
a     25
n a b 20
k   a 30 
; 
run;

data m;
set x;
L_name=scan(name,-1);
run;
proc print;
run;


********email id example**************;
data email; 
length id $25;
input id$;
datalines; 
a,b@n.com
b@tt.com
a@b@cc.com
;
run;
data n;
set email;
E_Address=scan(id,1,"@");
Domain_name=scan(id,-1,"@");
run;
proc print;
run;

/*6. Scan with multiple dlm*/
*The scan can read diff dlms if no third argument is provided;
data y;
str='a*b/k';
x=scan(str,1);
y=scan(str,2);
z=scan(str,-1);
run;


/*7. when the nth word does not exist*/
data a; 
x='amit~ka~school~tha~kv'; 
school=scan(x,6,'~'); 
run;
proc print data=a;
run;







/*3 Compress, Compbl, Strip*/

/*3.a. COMPRESS*/
/*Compress squeezes the string and takes the delimiter blank as default and same length as parent string, removes 
the leading and trailing blanks +internal blanks if blank is the delimiter which is the default case;*/

*1. compress;
data a;
x="a mi t   a b";
p=compress(x);
run;

proc print;
run;


*2. compress – delimiter;
data ab;
x="ami, t, a  ,b  ";
p=compress(x,',');
run;
proc print;
run;


/*3. Third argument, 1 dlm at a time */
* The SAS would not recognize the third argument in a compress function, so compress take only 2 arguments;
data ac;
x=" a, m  ,it,ab  ,~h";
p=compress(x,',','~'); *ERROR 72-185: The COMPRESS function call has too many arguments.;0
run;
proc print;
run;

** In case you want to delete multiple delimiters in one go, you need to put all delimiters in second argument 
in any order;
data ad;
x='ab,c,*&%$ ~d';
p=compress(x,'*&%$~ ,');
run;
proc print;
run;



/*3.B. COMPBL*/
*The compbl function compress the in between blanks as the name suggest and makes the blank gap to uniform 1, 
The LEADING MULTIPLE BLANKS ARE REDUCED TO 1 BLANK ONLY, length of output variable is same as that of parent variable;

data a;
x="     a     b  cc                    d";
p=compbl(x); *har jagah single blank kr dega ;
run;
proc print;
run;

* SAS fires error as compbl can have only one argument;
data a;
x='a**b*c*d*e';
y=compbl(x,'*');   *ERROR 72-185: The COMPBL function call has too many arguments.;
run;



/*3.c. STRIP*/
* It just strips the Leading & trailing blank(s) and no effect on internal blanks;
data a;
x=' a vc d  ';
y=strip(x);
run;
proc print;
run;

/**********************************************/







/* 4. INDEX,INDEXC,INDEXW*/

/* 1. INDEX*/
*The INDEX function searches the POSITION of the excerpt(piece of music or writing.) or required string in the source string 
and if excerpt is not found then it returns 0.;

data _null_;
x=' a vvd r es raj er';
y=index(x,'raj');
put y=;
run;

data _null_;
x=' a vvd r es raj er';
y='raj';
z=index(x,y);
put z=;
run;

/*2. index,trim and compress*/
* The index function can be used with the trim if the excerpt has trailing blanks, as trim removes the trailing blanks;
data _null_;
x='    a      cc  dd';
y='dd ';
z=index(x,trim(y)); *here it trim(remove leading & trailing spaces) Y then find position of the text in X string; 
put z=;
run;


data _null_; 
x='a cc dd '; 
y='dd ';
z=index(x,y);  *here the Y excerpt is similarly in X sting so it gives us answer;
put z=; 
run;

/*3. conditional processing*/
* The index function can be used to do conditional processing;
data x;
set sasuser.admit;
if index(actlevel,"HI") gt 0 then do;
output;
end;
run;


/*4.b. Indexc*/
*The INDEXC function searches for the occurrence of the FIRST CHARACTER of the first excerpt from left to right and
if nothing is found then returns 0, good thing about indexc is that it can take multiple excerpt strings as input.;

*it will return the first occurrence of any string to be searched irrespective of sequence of arguments;
data _null_;
x='abc def';
y=indexc(x, 'de','c');*here b/w 'de' and 'c' which is coming first in X string it will give the the output of that position;
put y=;
run;

data _null_;
x='abc def';
y=indexc(x,'bc', 'c');* here 'bc' is come first so its gives that position;
put y=;
run;




/*4.c. Indexw*/

* The indexw searches for words in the source string, here indexw searches for a whole word bd and it identifies word 
in source string by the delimiter blank, so there are 4 words in source string ab cd abd and bd, it does not pick abd
while it pics bd as bd is an individual word;


data _null_;
x='ab cd abd bd';
y=indexw(x,'bd'); *ye word pick krta h string me se or agar same word do baar h toh 1 wo word hoga uska position batayega; 
put y=;
run;


*it takes the delimiter as argument also*******************;
data _null_;
x='ab~cd~abd~bd';
y=indexw(x,'bd','~'); *here apart from space delimeter is ~ so we have to define the delimeter in third argument;
put y=;
run;





/*5. Left*/
*This function removes the leading blanks and the blanks now moves to right, thus the string gets aligned to LEFT,
the length of the new string is equal to the parent string;

*1. left;
data a;
x='   cc bb';
b=left(x);
c='*'||x||'*';
d='*'||b||'*';


put x=;
put b=;
put c=;
put d=;
run;




*2. Left and trim;
* This function removes the leading blanks (L) and aligns the string to left+ the trim 
function removes the trailing blanks so a good combo;

data x;
a=' cc bb ';
b=left(a);
c='*'||b||'*';
d='*'||trim(b)||'*';

put a=;
put b=;
put c=;
put d=;

run;




/*6. Right*/
*This function removes the trailing blanks and the blanks now moves to left, thus the string gets aligned to RIGHT,
the length of the new string is equal to the parent string.;

*here we can see by simple put it does not print leading or trailing blanks so we concatenated it with ‘*’ to
show up the leading and trailing blanks. ;
data x;
a='   cc  bb  ';
b=right(a);
c='*'||a||'*';
d='*'||b||'*';

put a=;
put b=;
put c=;
put d=;

run;


/*7.a. Trim*/
*This function removes the trailing blanks (you will be able to see results Only when you use it with concatenation).;


*here we can see by simple put it does not print leading or trailing blanks so we concatenated it with ‘*’ to show up
the leading and trailing blanks.;
data x;
a='cc bb ';
b=a||'*';
c=trim(a)||'*';
put b=;
put c=;

run;


*7.b. TRIMN;
*TRIM vs. TRIMN - Both TRIM and TRIMN remove trailing blanks from a character string. The only 
difference is how they deal with blank strings. If there is a blank string variable, the TRIM function
returns one blank whereas the TRIMN function returns no blank characters.;

data sample; 
input string $char14.; 
datalines; 
Mary Smith                 /* contains trailing blanks */
 John Brown                /* contains leading blanks */ 
 Alice Park                /* contains leading and trailing blanks */ 
 Tom    Wang               /* contains leading, trailing and multiple blanks in between */ 
		                   /* contains a blank string */
;
run;
*data ki value k aage comment h or ussi k hisab se string ki value h;
data x1;
set sample;
orignal='*'||string||'*';
trim='*'||trim(string)||'*'; * it will give the space when the data(5 observation) is blank;
trimn='*'||trimn(string)||'*'; *it will give no space when data(5 observation) is blank;

put orignal=;
put trim=;
put trimn=;

run;




/*8. TRANWARD*/
*The tranwrd function helps in the replacement of a string in a char variable.;


* 1. suppose you want to change in sasuser.admit the values of the actlevel ;
data amit (keep=actlevel1);
length actlevel1 $10;
set sasuser.admit;
actlevel1=tranwrd(lowcase(actlevel),'high','higher');
run;

*You can replace the existing variable as well************;
data amit;
set sasuser.admit;
actlevel=tranwrd(actlevel,'HI', 'ho');
run;

*2.Multiple occurrence;
* Converting the multiple occurence of a string;
data a;
input name$;
datalines;
highhigh 
high 
cc 
; 
run;
data x;
set a;
name=tranwrd(name,'high','ho');
run;
proc print;
run;

*The tranwrd function replaces a particular text of the variable in the dataset by a new text, lets say you want to
change the sex to nsex with M to Male;
data a;
set sasuser.admit;
nsex=tranwrd(sex,'M','male');
run;





/*9. TRANSLATE*/
*The translate function changes the string character wise the character in to & from should match, any a in string 
would be changed to 1 and so on.;
data x; 
name='amit kumar'; 
newname=translate(name,'123','ami'); *translate(string,to,from); 
run;
proc print data=x; 
run;

* The translate function changes the string character wise the character in to and from should match, any a in 
string would be changed here a would be changed to 1 , m to 2 and i to blank;
data x; name='amit kumar'; 
newname=translate(name,'12','ami'); /*translate(string,to,from)*/ 
run;
proc print data=x; 
run;

**ALSO if from is unbalanced then no issues***********;
data x; 
name='amit kumar'; 
newname=translate(name,'123','am'); /*translate(string,to,from)*/ 
run; proc print data=x; 
run;

***********Multiple Inputs********** * The inputs are fed in groups of to and from,here a is changed to 1 and m to 2 and
k to 3 and u to 4;
data x; 
name='amit kumar'; 
name=translate(name,'12','am','34','ku'); 
run; proc print data=x; 
run;

***********Last one prevails********* * If the from characters overlap then the last one prevails here first a points 
to 1 and second a to 9, so the second a prevails;
data x; 
name='amit kumar'; 
name=translate(name,'12','am','94','au');
run; proc print data=x;
run;



/*10. LOWCASE*/
*It converts the string in to small letters or in lower case.;
data amit;
x='AMIT';
y='Amit';
z='aMiT';

a=lowcase(x);
b=lowcase(x);
c=lowcase(x);
a1=lowcase('AMIT');
b1=lowcase('Amit');
c1=lowcase('aMiT');
run;



/*11. UPCASE*/
*It converts the string in to capital letters or in upper case.;
data amit;
x='amit';
y='Amit';
z='aMiT';

a=upcase(x);
b=upcase(x);
c=upcase(x);
a1=upcase('amit');
b1=upcase('Amit');
c1=upcase('aMiT');
run;


/*12. PROPCASE*/
*It converts the string in to proper case. First letter of each word in upper case and all other latters in lower case.;
data amit;
x='amit';
y='Amit';
z='aMiT';
p='jana is good boy';

a=propcase(x);
b=propcase(x);
c=propcase(x);
d=propcase(p);
a1=propcase('amit');
b1=propcase('Amit');
c1=propcase('aMiT');

run;





/*13. MEAN*/
*The mean sas function can be used to calculate the mean of the values.;
data amit;
x=10;
y=20;
age_mean=mean(10,20);
age_mean1=mean(x,y);
run;

*VARIABLE LIST***********; *The same output could be used if we pass the arguments as variable list;
data amit;
x1=10;
x2=20;
mean_age=mean( of x1-x2);/* If you omit the OF then it would calculate x1-x2 and the mean of the diff */
run;



/*14. QUARTER*/
*The qtr function calculates the Qauarter of the date and returns the value ranging from 1 to 4.;
data amit; 
set sasuser.empdata; 
qtrs=qtr(hiredate); 
run;


*Doing some subsetting**********;
data amit2; 
set sasuser.empdata; 
if qtr(hiredate) gt 2;
run;


*passing date value; 
data a; 
date='16feb2012'd; 
qtr=qtr(date); 
run;




/*15. SUM, SUM OF*/
*The SUM functions gives the sum of 2 or more variables. It also provides the sum of range if variables.;
data h;
x=4;
y=9;
z=3;
p=8;
x1=sum(4,9,3,8);
x2=sum(x,y,z,p);
run;

data h1;
x=sum(4,9,3,8,.); *Missing value still sum gets calculated;
run;

data h3;
x1=9; 
x2=39; 
x=sum(of x1-x2);  *Sum for Range;
run;



data h4;
x1=5; x2=6; x3=4; x4=9; 
y1=34; y2=12; y3=74; y4=39; 
result=sum(of x1-x4, of y1-y5); *Range of two variables;
run;

data h5;
x1=55; x2=35; x3=6; 
x4=sum(of x1-x3, 5);  *Range and a constant value;
run;

data h6;
x1=7; x2=7; 
x5=sum(x1-x2);   *As diff gets calculated;
run;

data h7;
y1=20; y2=30; 
x6=sum(of y:);  *Sum of all values of variable y;
run;


**The sum of function can be used to calculate table with the sum of range of variables;
data a; 
sale1=5; 
sale2=10;
sale3=15;
sale_sum=sum(of sale1-sale3); 
run;


**The second way could be if you want to include all sale variables, use the colon wild card;
data a;
sale1=5;
sale2=10;
sale3=15;
sale_sum=sum(of sale:);
run;


*The sum of function can be used to calculate table with the sum of range of variables, here just the 
sale1-sale4 sum is calculated and variable sale5 is created with null value;
data a; 
sale1=5;
sale2=10;
sale3=15;
sale4=5;
sale_sum=sum(of sale1-sale5);
run;



/*16. DAY*/
*The day function calculates the day of the date and returns the value ranging from 1 to 30/31.;
data amit;
x='16feb2020'd;
days=day(x);
run;
proc print;
run;
data amit;
set sasuser.empdata;
days=day(hiredate);
run;
proc print data=amit; 
var hiredate days; 
run;


**Doing some subsetting**********;
data amit2; 
set sasuer.empdata; 
if day(hiredate) gt 10; 
run;
proc print data=amit2; 
run;




/*17. YEAR*/
*The year function calculates the year from a date value.;
data amit;
x='16feb2020'd;
yr=year(x);
run;
proc print;
run;
data amit;
set sasuser.empdata;
yr=year(hiredate);
run;
proc print data=amit; 
var hiredate yr; 
run;


**Doing some subsetting***;
data amit2; 
set sasuser.empdata;
if year(hiredate)=1992;
run;
proc print data=amit2;
run;



/*18. WEEKDAY*/
*The weekday function calculates the day of the date and returns the value ranging from 1 to 7, 1 being the Sunday and
2 Monday and so on.;

data amit;
x='23jul2020'd;
dayofweek=weekday(x); *it will tells day of the week(starting from sunday); 
run;


data amit;
set sasuser.empdata;
wkday=weekday(hiredate);
run;
proc print data=amit;
var hiredate wkday;
run;

**Doing some subsetting***;
data amit2; 
set sasuer.empdata; 
if weekday(hiredate) gt 5;
run;
proc print data=amit2;
run;


/*19. Month*/
data amit;
x='23jul2020'd;
mon=month(x);
run;

data amit;
set sasuser.empdata;
mon=month(hiredate);
run;
proc print data=amit;
var hiredate mon;
run;


**Doing some subsetting***;
data amit2;
set sasuer.empdata;
if month(hiredate) gt 10; 
run;
proc print data=amit2; 
run;




/*20. MDY*/
*The mdy function creates a NUAMEREIC DATE from  the VALUES of the month day and year.;
data amit;
input name $ month year day; 
datalines;
amit 10 1981 13 
pre 04 1982 20 
; 
run;


data amit1;
set amit;
attrib bdy format=date9.;
bdy=mdy(month,day,year);
run;


**Practical use********;
data a; 
set sasuser.empdata; 

format hiredate1 date9.; 
m=month(hiredate); 
D=day(hiredate); 
y=year(hiredate); 
hiredate1=mdy(m,d,y); 
if hiredate ne hiredate1 then flag=1; 
else flag=0;
drop m d y;

run;
proc sql; 
select count(*) as cnt_flag_1 from a where flag=1;
quit;




/*21. Date and Today*/
*The date() or today() function can be used interchangeably and they do not need any arguments.;
data raj;
format current date9.;
current=today();
run;
proc print;
run;


data raj1;
format currentdate date7.;
currentdate=date();
run;






/*22. PUT*/
*The PUT function is used to convert the numeric values to the character values for the SAS.;


**If we do not use put function THE SAS LOG INDICATES THE NUMERIC TO CHARACTER CONVERSION OF THE AGE******;
data amit;
input name $ age monthsalary $ ; 
datalines;
amit 34 123,45.00 
na 23 213,45.00 
; 
run;
data amit1;
set amit;
nameage=name||'/'||age;
run;
proc print;
run;


data amit2;
set amit;
nameage=name||'/'|| put(age,2.);
run;
proc print;
run;



/*23. INPUT*/
*The Input function is used to convert the character values to the numeric values for the SAS to perform the
calculations.;

* Here salary is been converted from the character values to the numeric values;
data amit; 
input name $ age monthsalary $ ;
datalines;
amit 34 123,45.00 
na 23 213,45.00
; 
run;
data amit1;
set amit;
salary=input(monthsalary, comma9.2);
yearsal=salary*12;
run;






/*25. CAT*/
*The cat just concatenates the value of variables.;

*The CAT function specifies a constant, variable, or expression, either character or numeric. If item is numeric,
then its value is converted to a character string by using the BESTw. format. In this case, leading blanks are removed
and SAS does not write a note to the log.;

*Length of Returned Variable
In a DATA step, if the CAT function returns a value to a variable that has not previously been assigned a length, 
then that variable is given a length of 200 bytes. If the concatenation operator (||) returns a value to a variable that
has not previously been assigned a length, then that variable is given a length that is the sum of the lengths of the
values which are being concatenated. (ref. 1 example: kehna ye chahta h name ki length pehle wali hi rahegi fir sex ka 
length add ho jaegi 14byte of name & 1byte of sex.)

The cat function creates string of 200 bytes in length;
/*
Function Equivalent Code
CAT(OF X1-X4) X1||X2||X3||X4
*/
data a;
set sasuser.admit;
x=cat(name,sex);       *  >Raj M< ;
run;

*CAT function with a series 
*The cat just concatenates the value of variables, it just concatenates and does not remove space, leading or trailing;
data h;
x1='p';
x2='q';
x3='r';
z=cat(of x1-x3);
put z=;
run;


*CAT function with a series of vars with colon 
*The cat just concatenates the value of variables, it just concatenates and does not remove space, leading or trailing;
data j;
x1='p';
x2='q';
x3='r';
z=cat(of x:);
put z=;
run;



/*26. CATS*/
*The cats just concatenates the value of variables. The cats is just equal to Strip or trim(left(var));

*The CATS function specifies a constant, variable, or expression, either character or numeric. If item is numeric,
then its value is converted to a character string by using the BESTw. format. In this case, SAS does not write a note
to the log.

Length of Returned Variable
In a DATA step, if the CATS function returns a value to a variable that has not previously been assigned a length,
then that variable is given a length of 200 bytes. If the concatenation operator (||) returns a value to a variable
that has not previously been assigned a length, then that variable is given a length that is the sum of the lengths of 
the values which are being concatenated.

The cats function creates string of 200 bytes in length;
/*
Function Equivalent Code
CATS(OF X1-X4) TRIM(LEFT(X1))||TRIM(LEFT(X2))||TRIM(LEFT(X3))||TRIM(LEFT(X4))
*/
data g;
set sasuser.admit;          
x=cats(name,sex);  *  >RajM< ;
run;


*CATS function with a series 
*The cats just concatenates the value of variables, it concatenates and removes space, leading or trailing;
data b;
x1='p';
x2='q';
x3='r';
z=cats(of x1-x3);
run;
*CATS function with a series of vars with colon;
data c;
x1='p';
x2='q';
x3='r';
z=cats(of x:);
run;




/*27. CATT*/
*CatT is equal to TRIM. The catt just concatenates the value of variables, after applying the TRIM on them;

*The CATT function specifies a constant, variable, or expression, either character or numeric. If item is numeric,
then its value is converted to a character string by using the BESTw. format. In this case, leading blanks are removed
and SAS does not write a note to the log.

Length of Returned Variable
In a DATA step, if the CATT function returns a value to a variable that has not previously been assigned a length,
then that variable is given a length of 200 bytes. If the concatenation operator (||) returns a value to a variable
that has not previously been assigned a length, then that variable is given a length that is the sum of the lengths of
the values which are being concatenated.

The cats function creates string of 200 bytes in length;
/*
Function Equivalent Code
CATT(OF X1-X4) TRIM(X1)||TRIM(X2)||TRIM(X3)||TRIM(X4)
*/

data a;
set sasuser.admit;
y=catt(name,sex);
run;

*CATT function with a series;
data e;
x1='p';
x2='q';
x3='r';
z=catt(of x1-x3);
run;

*CATT function with a series of vars with colon;
data f;
x1='p';
x2='q';
x3='r';
z=catt(of x:);
run;





/*24. CATX*/
*The catx function helps in the concatenating of the character strings and no need of left trim.;

*The CATX function first copies item-1 to the result, omitting leading and trailing blanks. Then for each subsequent
argument item-i, i=2, ..., n, if item-i contains at least one non-blank character, then CATX appends delimiter and
item-i to the result, omitting leading and trailing blanks from item-i. CATX does not insert the delimiter at the
beginning or end of the result. Blank items do not produce delimiters at the beginning or end of the result,
nor do blank items produce multiple consecutive delimiters.

Length of Returned Variable
In a DATA step, if the CATX function returns a value to a variable that has not previously been assigned a length,
then that variable is given a length of 200 bytes. If the concatenation operator (||) returns a value to a variable that
has not previously been assigned a length, then that variable is given a length that is the sum of the lengths of the
values which are being concatenated..

The catx function creates string of 200 bytes in length;
/*
Function Equivalent Code
CATX(SP, OF X1-X4) TRIM(LEFT(X1))||SP||TRIM(LEFT(X2))||SP||TRIM(LEFT(X3))||SP||TRIM(LEFT(X4))
*/

data a;
set sasuser.admit;
s=catx(',',actlevel,sex);
run;

proc sql;
describe table a;
quit;


data amit;
input name $ month year day; 
datalines; 
amit 10 1981 13 
pre 04 1982 20 
;
run;

data amit1;
set amit;
total=catx('*',name,month,year,day);
run;


*CATX function with a series 
Lets say you want to concatenate the value of a variable;
data a;
Qs='\';
x1='a';
x2='b';
x3='c';
z=catx(Qs,of x1-x3);
run;


*CATX function with a series of vars with colon
*The catx just concatenates the value of variables with the colon operator on variable x;
data b;
Qs='\';
x1='a';
x2='b';
x3='c';
z=catx(Qs,of x:);
run;








/*28. FIND*/
* The find and index have the following differences;

/*
1. The FIND function searches for substrings of characters in a character string, whereas the FINDC function searches 
for individual characters in a character string.
2. The FIND function and the INDEX function both search for SUBSTRINGS of characters in a character string. However, 
the INDEX function does not have the modifiers nor the start pos arguments.
*/

*lets test the find function and the value returned, here score has a value 4 name is the 4 char in string;
data a;
x='my name is raj';
scr=find(x,'name');
put scr=;
run;

*FIND function with a modifier ***The i modifier ignores the case of substring;
data a; 
x='my NAME is amit';
scr=find(x,'name','i');
run;

***The t modifier strips the leading and the trailing spaces in string and substring;
data a; 
x='my name is amit'; 
score=find(x,'name','t'); 
put score=; 
run;

data a; 
x='my name is amit'; 
score=find(x,'is','t'); 
put score=; 
run;

* The Find function helps in the searching of a string in the character variable, it returns the position of the 
string if found else 0;

data hum;
set sasuser.admit;
run;
data hum1;
set hum;
if find(name,'be','t') gt 0;  * that modifier here trims the trailing blanks of the name var;
run;


*FIND RETURNS THE STRING POSITION************:
* we can find the string position 'be', lets assign value of be to a var x;
data amit (keep=name x);
set sasuser.admit;
x=find(name,'be','t');
run;




/*29. COUNT*/
*The count function is used to count the ocuurence of a substring in a string;
data a; 
x='My name is amit kumar, my expertise is sas';
count_is=count(x,'is');
put count_is=;
run;

data a; 
x='My name is amit kumar, my expertise is sas';
count_my=count(x,'my');
put count_my=;
run;

*Modifiers in count ***The count again take two modifiers similar to find, the i and t, i for ignoring the case and t 
for trimming the balnk space;
data a; 
x='My name is amit kumar, my expertise is sas';
count_my=count(x,'my','i');
put count_my=;
run;






/*30. COUNTW*/
*This function counts the number of WORDS in a string;
data a;
x='my name is raj';
cnt_w=countw(x);
put cnt_w=;
run;



/*31. INT*/
*The INT function returns the integer value of a numeric variable, thus discarding the 
decimal portion;
data amit;
x=1320.7;
y=int(x);
put y=;
run;






/*32. ROUND*/

*The ROUND function returns rounded value of a decimal number and by default it is 1, any value ge .50 would be in the 
next integer;

data amit; 
x1=123.89; 
x2=123.28;
x3=123.46; 
x4=123.00;
x5=123.99;
x6=123.50;

y1=round(x1,2);
y2=round(x2);
y3=round(x3);
y4=round(x4);
y5=round(x5); 
y6=round(x6);
run;
proc print;
run;





/*33. N*/
*The N function COUNTS THE NUMBER OF NON-MISSING VALUES in a row;
data a;
x1=5;
x2=6;
x3=7;

nvar_nonmiss=n(of x1-x3);
put nvar_nonmiss=;
run;

**or using the colon as the wild character;
data b;
x1=5;
x2=6;
x3=7;

nvar_nonmiss=n(of x:);
put nvar_nonmiss=;
run;




/*34. NMISS*/
*The NMISS function counts the number of missing values in a row.;
data b;
x1=5;
x2=6;
x3=.;

nvar_nmiss=nmiss(of x1-x3);
put nvar_nmiss=;
run;

**or using the colon as the wild character;
data a;
x1=5;
x2=6;
x3=.;

nvar_nmiss=nmiss(of x:);
put nvar_nmiss=;
run;





/*35. INTCK*/
*The INTCK function returns the value of the complete interval passed between two dates, it can take diff arguments 
like week, month, year.;
data amit;
x='31dec2020'd;
y='01jan2021'd;

x1=input(x,date9.);
y1=input(y,date9.);

z1=intck('week',x,y);
z2=intck('month',x,y);
z3=intck('year',x,y);
run;



***or make the date as a value using the d****;
data amit;
x='31dec2020'd;
y='01jan2021'd;


z1=intck('week',x,y);
z2=intck('month',x,y);
z3=intck('year',x,y);
run;


**AGE FINDING*****;
data amit; 
x='13oct1981'; 
y='01jul2010';

x1=input(x,date9.);
y1=input(y,date9.);

z3=intck('year',x1,y1);
run;

*Lets try to find the age by using the system date;
data a;
x='04may1989'd;
dob=intck('yr',x,today());
put dob=;
run;





	
/*36. INTNX*/
*The INTNX function increments the day, year or month on the specified date, here it increments the date by 6 weeks,
means date after 6 weeks including current week.;
data _null_;
x=intnx('week','25jul2020'd,2);
put x date9.;
run;



* The intnx function increments the day, year or month on the specified date, you can use put as well;
data a;
x='25jul2020'd;
y=put(intnx('month',x,1,'e'),date9.);
put y=;
run;



* The intnx function increments the day, year or month on the specified date, you can use the same argument for 
incrementing 1 month from the date;
data amit; 
x='25jul2020'd;
z=put(intnx('month',x,1,'same'),date9.);
put z=; 
run;




* The intnx function increments the day, year or month on the specified date, you can use the b or beginning argument 
then the output date would be 1 month and first day.;
data amit; 
x='25jul2020'd;
z=put(intnx('month',x,1,'b'),date9.);
put z=;
run;


* The intnx function increments the day, year or month on the specified date, you can use the e or end argument then 
the output date would be 1 month and first day.;
data amit; 
x='25jul2020'd;
z=put(intnx('month',x,1,'e'),date9.);
put z=;
run;





/*37. Datdif n yrdif*/
*The datdif and yrdif function helps in calculating the days and year diff between the two dates.

'ACT/ACT'
uses the actual number of days between dates in calculating the number of years. SAS calculates this value as the number
of days that fall in 365-day years divided by 365 plus the number of days that fall in 366-day years divided by 366.;
data amit;
x='25jul2020';
y='02jan2050';
x1=input(x,date9.);
y1=input(y,date9.);
z1=yrdif(x1,y1,'actual');
z2=datdif(x1,y1,'actual');
run;



*The today() function can be used as well for finding the age;
data amit;
x='04may1989';
x1=input(x,date9.);
z1=yrdif(x1,today(),'actual');
z2=datdif(x1,date(),'actual');
run;

data amit;
x='04may1989';
x1=input(x,date9.);
z1=yrdif(x1,today(),'actual');
z2=datdif(x1,today(),'actual');
run;






/*38. REVERSE*/
*The reverse function just REVERSE THE STRING, if there are leading blanks they become trailing.;
data a;
x='abc';
y=reverse(x);
put y=;
run;

* Let's say you have drug data, how would you take out the dose strength in a new variable;
data a;
input trt$;
datalines;
a150
b120
130
dc300
;
run;
data b;
set a;
dose=reverse(substr(reverse(compress(trt)),1,3));
put dose=;
run;

/*******************************************************************/


/* WhichN Function */
/* vName Function */



