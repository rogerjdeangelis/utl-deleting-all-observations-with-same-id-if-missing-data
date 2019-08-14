Deleting all observations with same id if missing data                                                                    
                                                                                                                          
  Eight Solutions                                                                                                         
                                                                                                                          
      a. Elegant simple hash                                                                                              
         Patrick                                                                                                          
         https://communities.sas.com/t5/user/viewprofilepage/user-id/12447                                                
                                                                                                                          
      b. SQL delete from have where from have where exist and id with missing income                                      
         Patrick                                                                                                          
         https://communities.sas.com/t5/user/viewprofilepage/user-id/12447                                                
                                                                                                                          
      c. Merge                                                                                                            
         novinosrin                                                                                                       
         https://communities.sas.com/t5/user/viewprofilepage/user-id/138205                                               
                                                                                                                          
      d. sql not in                                                                                                       
         novinosrin                                                                                                       
         https://communities.sas.com/t5/user/viewprofilepage/user-id/138205                                               
                                                                                                                          
      e. SQL having                                                                                                       
         pgstats                                                                                                          
         https://communities.sas.com/t5/user/viewprofilepage/user-id/462                                                  
                                                                                                                          
      f. DOW                                                                                                              
         r_behata                                                                                                         
         https://communities.sas.com/t5/user/viewprofilepage/user-id/223452                                               
                                                                                                                          
      g. Faster DOW (may be the fastest of all if by group cached in memory?  )                                           
         Roger DeAngelis (first presented by Paul Dorfman )                                                               
                                                                                                                          
      h. Hash Check mutiple vars for missings                                                                             
         Patrick                                                                                                          
         https://communities.sas.com/t5/user/viewprofilepage/user-id/12447                                                
                                                                                                                          
                                                                                                                          
github                                                                                                                    
https://tinyurl.com/y5629he4                                                                                              
https://github.com/rogerjdeangelis/utl-deleting-all-observations-with-same-id-if-missing-data                             
                                                                                                                          
SAS Forum                                                                                                                 
https://tinyurl.com/yyx2g65r                                                                                              
https://communities.sas.com/t5/SAS-Programming/Deleting-all-observations-with-same-ID-if-missing-data/m-p/580972          
                                                                                                                          
*              _                 _        _               _                                                               
  __ _     ___(_)_ __ ___  _ __ | | ___  | |__   __ _ ___| |__                                                            
 / _` |   / __| | '_ ` _ \| '_ \| |/ _ \ | '_ \ / _` / __| '_ \                                                           
| (_| |_  \__ \ | | | | | | |_) | |  __/ | | | | (_| \__ \ | | |                                                          
 \__,_(_) |___/_|_| |_| |_| .__/|_|\___| |_| |_|\__,_|___/_| |_|                                                          
                          |_|                                                                                             
;                                                                                                                         
                                                                                                                          
Patric                                                                                                                    
https://communities.sas.com/t5/user/viewprofilepage/user-id/12447                                                         
                                                                                                                          
                                                                                                                          
data have;                                                                                                                
input ID Gender Income ;                                                                                                  
cards;                                                                                                                    
1 1 5000                                                                                                                  
1 1 7000                                                                                                                  
1 1 .                                                                                                                     
2 2 3000                                                                                                                  
2 2 5000                                                                                                                  
2 2 1000                                                                                                                  
3 1 .                                                                                                                     
3 1 900000                                                                                                                
3 1 12345                                                                                                                 
;                                                                                                                         
run;quit;                                                                                                                 
                                                                                                                          
data want;                                                                                                                
  if _n_=1 then                                                                                                           
    do;                                                                                                                   
      dcl hash h1(dataset:'have(where=(missing(income)))', duplicate:'r');                                                
      h1.defineKey('id');                                                                                                 
      h1.defineDone();                                                                                                    
    end;                                                                                                                  
  set have;                                                                                                               
  if h1.check() eq 0 then delete;                                                                                         
run;                                                                                                                      
                                                                                                                          
*_                  _       _      _      _                                                                               
| |__     ___  __ _| |   __| | ___| | ___| |_ ___                                                                         
| '_ \   / __|/ _` | |  / _` |/ _ \ |/ _ \ __/ _ \                                                                        
| |_) |  \__ \ (_| | | | (_| |  __/ |  __/ ||  __/                                                                        
|_.__(_) |___/\__, |_|  \__,_|\___|_|\___|\__\___|                                                                        
                 |_|                                                                                                      
;                                                                                                                         
                                                                                                                          
data have;                                                                                                                
input ID Gender Income ;                                                                                                  
cards;                                                                                                                    
1 1 5000                                                                                                                  
1 1 7000                                                                                                                  
1 1 .                                                                                                                     
2 2 3000                                                                                                                  
2 2 5000                                                                                                                  
2 2 1000                                                                                                                  
3 1 .                                                                                                                     
3 1 900000                                                                                                                
3 1 12345                                                                                                                 
;                                                                                                                         
run;quit;                                                                                                                 
proc sql;                                                                                                                 
  delete from have o                                                                                                      
  where exists                                                                                                            
  (select * from have i where i.income is missing and i.id=o.id)                                                          
  ;                                                                                                                       
quit;                                                                                                                     
                                                                                                                          
*                                                                                                                         
  ___     _ __ ___   ___ _ __ __ _  ___                                                                                   
 / __|   | '_ ` _ \ / _ \ '__/ _` |/ _ \                                                                                  
| (__ _  | | | | | |  __/ | | (_| |  __/                                                                                  
 \___(_) |_| |_| |_|\___|_|  \__, |\___|                                                                                  
                             |___/                                                                                        
;                                                                                                                         
novinosrin                                                                                                                
https://communities.sas.com/t5/user/viewprofilepage/user-id/138205                                                        
                                                                                                                          
data have;                                                                                                                
input ID Gender Income ;                                                                                                  
cards;                                                                                                                    
1 1 5000                                                                                                                  
1 1 7000                                                                                                                  
1 1 .                                                                                                                     
2 2 3000                                                                                                                  
2 2 5000                                                                                                                  
2 2 1000                                                                                                                  
3 1 .                                                                                                                     
3 1 900000                                                                                                                
3 1 12345                                                                                                                 
;                                                                                                                         
run;quit;                                                                                                                 
data want;                                                                                                                
merge have(in=a where=(missing(income))) have(in=b) ;                                                                     
by id;                                                                                                                    
if b and not a;                                                                                                           
run;                                                                                                                      
*    _               _               _     _                                                                              
  __| |    ___  __ _| |  _ __   ___ | |_  (_)_ __                                                                         
 / _` |   / __|/ _` | | | '_ \ / _ \| __| | | '_ \                                                                        
| (_| |_  \__ \ (_| | | | | | | (_) | |_  | | | | |                                                                       
 \__,_(_) |___/\__, |_| |_| |_|\___/ \__| |_|_| |_|                                                                       
                  |_|                                                                                                     
;                                                                                                                         
                                                                                                                          
                                                                                                                          
data have;                                                                                                                
input ID Gender Income ;                                                                                                  
cards;                                                                                                                    
1 1 5000                                                                                                                  
1 1 7000                                                                                                                  
1 1 .                                                                                                                     
2 2 3000                                                                                                                  
2 2 5000                                                                                                                  
2 2 1000                                                                                                                  
3 1 .                                                                                                                     
3 1 900000                                                                                                                
3 1 12345                                                                                                                 
;                                                                                                                         
run;quit;                                                                                                                 
                                                                                                                          
proc sql;                                                                                                                 
create table want as                                                                                                      
select *                                                                                                                  
from have                                                                                                                 
where id not in (select id from have where missing(income));                                                              
quit;                                                                                                                     
                                                                                                                          
*                   _   _                 _                                                                               
  ___     ___  __ _| | | |__   __ ___   _(_)_ __   __ _                                                                   
 / _ \   / __|/ _` | | | '_ \ / _` \ \ / / | '_ \ / _` |                                                                  
|  __/_  \__ \ (_| | | | | | | (_| |\ V /| | | | | (_| |                                                                  
 \___(_) |___/\__, |_| |_| |_|\__,_| \_/ |_|_| |_|\__, |                                                                  
                 |_|                              |___/                                                                   
;                                                                                                                         
                                                                                                                          
                                                                                                                          
pgstats                                                                                                                   
https://communities.sas.com/t5/user/viewprofilepage/user-id/462                                                           
                                                                                                                          
proc sql;                                                                                                                 
create table want as                                                                                                      
select *                                                                                                                  
from have                                                                                                                 
group by ID                                                                                                               
having count(INCOME) = count(*);                                                                                          
quit;                                                                                                                     
                                                                                                                          
* __        _                                                                                                             
 / _|    __| | _____      __                                                                                              
| |_    / _` |/ _ \ \ /\ / /                                                                                              
|  _|  | (_| | (_) \ V  V /                                                                                               
|_|(_)  \__,_|\___/ \_/\_/                                                                                                
                                                                                                                          
;                                                                                                                         
                                                                                                                          
r_behata                                                                                                                  
https://communities.sas.com/t5/user/viewprofilepage/user-id/223452                                                        
                                                                                                                          
data have;                                                                                                                
input ID Gender Income ;                                                                                                  
cards;                                                                                                                    
1 1 5000                                                                                                                  
1 1 7000                                                                                                                  
1 1 .                                                                                                                     
2 2 3000                                                                                                                  
2 2 5000                                                                                                                  
2 2 1000                                                                                                                  
3 1 .                                                                                                                     
3 1 900000                                                                                                                
3 1 12345                                                                                                                 
4 2 3300                                                                                                                  
4 2 5300                                                                                                                  
4 2 1300                                                                                                                  
;                                                                                                                         
run;quit;                                                                                                                 
                                                                                                                          
data want;                                                                                                                
do until(last.id);                                                                                                        
      set have;                                                                                                           
      by id;                                                                                                              
      if missing(income) then miss=sum(miss,1);                                                                           
end;                                                                                                                      
                                                                                                                          
do until(last.id);                                                                                                        
      set have;                                                                                                           
      by id;                                                                                                              
      if miss< 0 then output;                                                                                             
end;                                                                                                                      
                                                                                                                          
drop miss;                                                                                                                
run;                                                                                                                      
                                                                                                                          
*           __           _                  _                                                                             
  __ _     / _| __ _ ___| |_ ___ _ __    __| | _____      __                                                              
 / _` |   | |_ / _` / __| __/ _ \ '__|  / _` |/ _ \ \ /\ / /                                                              
| (_| |_  |  _| (_| \__ \ ||  __/ |    | (_| | (_) \ V  V /                                                               
 \__, (_) |_|  \__,_|___/\__\___|_|     \__,_|\___/ \_/\_/                                                                
 |___/                                                                                                                    
;                                                                                                                         
                                                                                                                          
Roger                                                                                                                     
                                                                                                                          
data have;                                                                                                                
input ID Gender Income ;                                                                                                  
cards;                                                                                                                    
1 1 5000                                                                                                                  
1 1 7000                                                                                                                  
1 1 .                                                                                                                     
2 2 3000                                                                                                                  
2 2 5000                                                                                                                  
2 2 1000                                                                                                                  
3 1 .                                                                                                                     
3 1 900000                                                                                                                
3 1 12345                                                                                                                 
4 2 3300                                                                                                                  
4 2 5300                                                                                                                  
4 2 1300                                                                                                                  
;                                                                                                                         
run;quit;                                                                                                                 
data want;                                                                                                                
do _n_ = 1 by 1 until(last.id);                                                                                           
      set have;                                                                                                           
      by id;                                                                                                              
      if missing(income) then flg=0;                                                                                      
end;                                                                                                                      
do _n_=1 to _n_;                                                                                                          
      set have;                                                                                                           
      if flg ne 0 then output;                                                                                            
end;                                                                                                                      
drop flg;                                                                                                                 
run;                                                                                                                      
                                                                                                                          
*_              _     _                                                                                                   
| |__       ___| |__ | | __  _ __ ___   __ _ _ __  _   _  __   ____ _ _ __ ___                                            
| '_ \     / __| '_ \| |/ / | '_ ` _ \ / _` | '_ \| | | | \ \ / / _` | '__/ __|                                           
| | | |_  | (__| | | |   <  | | | | | | (_| | | | | |_| |  \ V / (_| | |  \__ \                                           
|_| |_(_)  \___|_| |_|_|\_\ |_| |_| |_|\__,_|_| |_|\__, |   \_/ \__,_|_|  |___/                                           
                                                   |___/                                                                  
                                                                                                                          
Ksharpe                                                                                                                   
https://communities.sas.com/t5/user/viewprofilepage/user-id/18408                                                         
                                                                                                                          
                                                                                                                          
data have;                                                                                                                
input PID Gender Income Net_worth;                                                                                        
datalines;                                                                                                                
1 1 4999 .                                                                                                                
1 1 . 111                                                                                                                 
1 1 131 1441                                                                                                              
2 2 1000 555                                                                                                              
2 2 2000 24443                                                                                                            
2 2 3000 59530                                                                                                            
3 1 155 .                                                                                                                 
3 1 122 12312                                                                                                             
3 1 1244 .                                                                                                                
;                                                                                                                         
                                                                                                                          
data want;                                                                                                                
   if _N_=1 then do;                                                                                                      
      declare hash h(dataset:'have(where=(nmiss(Income, Net_worth) ge 1)');                                               
      h.defineKey('PID');                                                                                                 
      h.defineDone();                                                                                                     
   end;                                                                                                                   
                                                                                                                          
   set have;                                                                                                              
   if h.check() ne 0;                                                                                                     
run;                                                                                                                      
                                                                                                                          
