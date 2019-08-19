# utl-deleting-all-observations-with-same-id-if-missing-data
    Deleting all observations with same id if missing data                                                                    
                                                                                                                              
    Twelve Solutions                                                                                                          
                                                                                                                              
          a. Elegant simple hash                                                                                              
             Patrick                                                                                                          
             https://communities.sas.com/t5/user/viewprofilepage/user-id/12447                                                
                                                                                                                              
          b. SQL delete from have where exist and id with missing income                                                      
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
                                                                                                                              
          g. Faster DOW (maybe the fastest of all if by group cached in memory?  )                                            
             Roger DeAngelis (first presented by Paul Dorfman )                                                               
                                                                                                                              
          h. Hash Check multiple vars for missings                                                                            
             Patrick                                                                                                          
             https://communities.sas.com/t5/user/viewprofilepage/user-id/12447                                                
                                                                                                                              
          i. Sort chk 1st miss (related solution)                                                                             
             Paul Dorfman                                                                                                     
             sashole@bellsouth.net                                                                                            
                                                                                                                              
          k. Recap + hash rid (very usefull technique for large data)                                                         
             Paul Dorfman                                                                                                     
             sashole@bellsouth.net                                                                                            
                                                                                                                              
          l. ds2 nice sql                                                                                                     
             Richard DeVenezia                                                                                                
             rdevenezia@gmail.com                                                                                             
                                                                                                                              
          m. very fast single pass hash solution                                                                              
             Bartosz Jablonski                                                                                                
             yabwon@gmail.com                                                                                                 
                                                                                                                              
                                                                                                                              
    github                                                                                                                    
    https://tinyurl.com/y5629he4                                                                                              
    https://github.com/rogerjdeangelis/utl-deleting-all-observations-with-same-id-if-missing-data                             
                                                                                                                              
    SAS Forum                                                                                                                 
    https://tinyurl.com/yyx2g65r                                                                                              
    https://communities.sas.com/t5/SAS-Programming/Deleting-all-observations-with-same-ID-if-missing-data/m-p/580972          
                                                                                                                              
    *_                   _                                                                                                    
    (_)_ __  _ __  _   _| |_                                                                                                  
    | | '_ \| '_ \| | | | __|                                                                                                 
    | | | | | |_) | |_| | |_                                                                                                  
    |_|_| |_| .__/ \__,_|\__|                                                                                                 
            |_|                                                                                                               
    ;                                                                                                                         
                                                                                                                              
    WORK.HAVE total obs=9                                                                                                     
                                                                                                                              
      ID    GENDER    INCOME  |  RULE                                                                                         
                              |                                                                                               
       1       1        5000  |  Delete all if ID=1 because we                                                                
       1       1        7000  |  have at least on missing                                                                     
       1       1           .  |                                                                                               
                              |                                                                                               
       2       2        3000  |  Keep ID=2 no missing                                                                         
       2       2        5000  |                                                                                               
       2       2        1000  |                                                                                               
                              |                                                                                               
       3       1           .  |                                                                                               
       3       1      900000  |  Delete all if ID=1 because we                                                                
       3       1       12345  |  have at least on missing                                                                     
                              |                                                                                               
                                                                                                                              
    *            _               _                                                                                            
      ___  _   _| |_ _ __  _   _| |_                                                                                          
     / _ \| | | | __| '_ \| | | | __|                                                                                         
    | (_) | |_| | |_| |_) | |_| | |_                                                                                          
     \___/ \__,_|\__| .__/ \__,_|\__|                                                                                         
                    |_|                                                                                                       
                                                                                                                              
     WORK.WANT total obs=3                                                                                                    
                                                                                                                              
      ID    GENDER    INCOME                                                                                                  
                                                                                                                              
       2       2       3000                                                                                                   
       2       2       5000                                                                                                   
       2       2       1000                                                                                                   
                                                                                                                              
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
                                                                                                                              
                                                                                                                              
                                                                                                                              
                                                                                                                              
    data have ;                                                                                                               
      input id gender income ;                                                                                                
    cards;                                                                                                                    
    1  1  5000                                                                                                                
    1  1     .                                                                                                                
    1  1  7000                                                                                                                
    1  1     .                                                                                                                
    2  2  3000                                                                                                                
    2  2  5000                                                                                                                
    2  2  1000                                                                                                                
    3  1   .                                                                                                                  
    3  1  900000                                                                                                              
    3  1  12345                                                                                                               
    ;                                                                                                                         
    run ;                                                                                                                     
                                                                                                                              
                                                                                                                              
    *_                    _          _     _      _     _               _                                                     
    (_)    ___  ___  _ __| |_    ___| |__ | | __ / |___| |_   _ __ ___ (_)___ ___                                             
    | |   / __|/ _ \| '__| __|  / __| '_ \| |/ / | / __| __| | '_ ` _ \| / __/ __|                                            
    | |_  \__ \ (_) | |  | |_  | (__| | | |   <  | \__ \ |_  | | | | | | \__ \__ \                                            
    |_(_) |___/\___/|_|   \__|  \___|_| |_|_|\_\ |_|___/\__| |_| |_| |_|_|___/___/                                            
                                                                                                                              
    ;                                                                                                                         
                                                                                                                              
                                                                                                                              
    has apparently been sorted by ID (and perhaps GENDER, which is irrelevant).                                               
    If s/he had thought of sorting it at the same time by INCOME, no one would                                                
    have to invent any clever solutions since a primitive single                                                              
    pass would do the trick:                                                                                                  
                                                                                                                              
    /* the way HAVE should have been sorted */                                                                                
    proc sort data = have ;                                                                                                   
      by id income ;                                                                                                          
    run ;                                                                                                                     
                                                                                                                              
    /* the rest is a piece of cake */                                                                                         
    data want ;                                                                                                               
      set have ;                                                                                                              
      by id ;                                                                                                                 
      if first.id then _iorc_ = ifn (cmiss (income), 0, 1) ;                                                                  
      if _iorc_ ;                                                                                                             
    run;quit;                                                                                                                 
                                                                                                                              
    *_                                       _               _            _     _                                             
    | | __    _ __ ___  ___ __ _ _ __    _  | |__   __ _ ___| |__    _ __(_) __| |                                            
    | |/ /   | '__/ _ \/ __/ _` | '_ \ _| |_| '_ \ / _` / __| '_ \  | '__| |/ _` |                                            
    |   < _  | | |  __/ (_| (_| | |_) |_   _| | | | (_| \__ \ | | | | |  | | (_| |                                            
    |_|\_(_) |_|  \___|\___\__,_| .__/  |_| |_| |_|\__,_|___/_| |_| |_|  |_|\__,_|                                            
                                |_|                                                                                           
    ;                                                                                                                         
                                                                                                                              
    To recap, given this:                                                                                                     
                                                                                                                              
    data have ;                                                                                                               
      input id gender income ;                                                                                                
    cards;                                                                                                                    
    1  1  5000                                                                                                                
    1  1     .                                                                                                                
    1  1  7000                                                                                                                
    1  1     .                                                                                                                
    2  2  3000                                                                                                                
    2  2  5000                                                                                                                
    2  2  1000                                                                                                                
    3  1   .                                                                                                                  
    3  1  900000                                                                                                              
    3  1  12345                                                                                                               
    ;                                                                                                                         
    run ;                                                                                                                     
                                                                                                                              
    we need to eliminate all same-ID groups of records where at least one record has                                          
     INCOME missing (so, in the above case, only group ID=2 remains).                                                         
                                                                                                                              
    Methinks the hash approach is best since it (a) doesn't require the input to                                              
    be sorted (not sorts it behind-the-scenes) and (b) in fact, quite simple.                                                 
    The hash's other advantages are: (a) its input is auto-deduped by ID and (b)                                              
    it acts only the variables it needs.                                                                                      
                                                                                                                              
    data want ;                                                                                                               
      if _n_ = 1 then do ;                                                                                                    
        dcl hash h (dataset:"have(where=(income is null))") ;                                                                 
        h.definekey ("id") ;                                                                                                  
        h.definedone () ;                                                                                                     
      end ;                                                                                                                   
      set have ;                                                                                                              
      if h.check() ne 0 ;                                                                                                     
    run ;                                                                                                                     
                                                                                                                              
    Now if the file is already sorted,                                                                                        
    MERGE seems to be just the ticket, plus it's the tersest:                                                                 
                                                                                                                              
    data want ;                                                                                                               
      merge have (in=x) have (keep=id income where=(missing(income)) in=y) ;                                                  
      by id ;                                                                                                                 
      if x and not y ;                                                                                                        
    run ;                                                                                                                     
                                                                                                                              
    However, there're a couple of things in terms of what I don't like to see:                                                
                                                                                                                              
    INFO: The variable income on data set WORK.HAVE                                                                           
    will be overwritten by data set WORK.HAVE.                                                                                
    NOTE: MERGE statement has more than one data set with repeats of BY values.                                               
                                                                                                                              
    The first eventuality cannot be avoided since for the WHERE clause INCOME                                                 
     must be kept. The second arises because if there are more then one                                                       
    missing INCOME per ID, the second HAVE (unlike the hash) doesn't dedup them.                                              
                                                                                                                              
    Thus, the double DOW is cleaner:                                                                                          
                                                                                                                              
    data want (drop = _:) ;                                                                                                   
      do _n_ = 1 by 1 until (last.id) ;                                                                                       
        set have (keep = id income) ;                                                                                         
        by id ;                                                                                                               
        if missing (income) then _f = 1 ;                                                                                     
      end ;                                                                                                                   
      do _n_ = 1 to _n_ ;                                                                                                     
        set have ;                                                                                                            
        if not _f then output ;                                                                                               
      end ;                                                                                                                   
    run ;                                                                                                                     
                                                                                                                              
    It's only shortcoming is that the filtering is effectively                                                                
    done using IF rather than WHERE. A somewhat equivalent form that                                                          
    would fix that (Howard Schreier would like it) could be:                                                                  
                                                                                                                              
    data want ;                                                                                                               
      set have (keep=id income where=(income is null) in=_in1) have  ;                                                        
      by id ;                                                                                                                 
      if first.id then _iorc_ = 1 ;                                                                                           
      if _in1 then do ;                                                                                                       
        if missing (income) then _iorc_ = 0 ;                                                                                 
      end ;                                                                                                                   
      else if _iorc_ then output ;                                                                                            
    run ;                                                                                                                     
                                                                                                                              
    I'm not sure whether SQL can foster better performance                                                                    
    since I can't figure out how to efficiently force it into                                                                 
    the hash mode under this particular arrangement.                                                                          
                                                                                                                              
    However, there can exist a special practical case where a                                                                 
    different approach might be much faster than anything else,                                                               
    namely: If HAVE is a hugely long file with relatively few                                                                 
    relatively short same-ID groups having missing INCOME among                                                               
    their records. In this case, the RIDs for these groups can                                                                
    be gathered in a single pass through the file, after which                                                                
    they can be used to mark the c                                                                                            
    orresponding records in HAVE for deletion. For example:                                                                   
                                                                                                                              
    data rid (keep = rid) ;                                                                                                   
      do until (last.id) ;                                                                                                    
        set have (keep = id income) curobs = q ;                                                                              
        by id ;                                                                                                               
        if first.id then _q1 = q ;                                                                                            
        if missing (income) then _mf = 1 ;                                                                                    
      end ;                                                                                                                   
      if _mf then do rid = _q1 to q ;                                                                                         
        output ;                                                                                                              
      end ;                                                                                                                   
    run ;                                                                                                                     
                                                                                                                              
    data have ;                                                                                                               
      set rid ;                                                                                                               
      modify have point = rid ;                                                                                               
      remove ;                                                                                                                
    run ;                                                                                                                     
                                                                                                                              
    The idea behind this method is of course the same as in:                                                                  
                                                                                                                              
    https://tinyurl.com/y58zae6s                                                                                              
    https://support.sas.com/content/dam/SAS/support/en/sas-global-forum-proceedings/2018/2426-2018.pdf                        
                                                                                                                              
    where it is used to delete duplicates.                                                                                    
    Perhaps a little bit more efficient would be to store just the RID endpoints in file RID:                                 
                                                                                                                              
    data rid (keep = rid_:) ;                                                                                                 
      do until (last.id) ;                                                                                                    
        set have (keep = id income) curobs = q ;                                                                              
        by id ;                                                                                                               
        if first.id then rid_from = q ;                                                                                       
        if missing (income) then _mf = 1 ;                                                                                    
      end ;                                                                                                                   
      if _mf ;                                                                                                                
      rid_to = q ;                                                                                                            
    run ;                                                                                                                     
                                                                                                                              
    data have ;                                                                                                               
      set rid ;                                                                                                               
      do rid = rid_from to rid_to ;                                                                                           
        modify have point = rid ;                                                                                             
        remove ;                                                                                                              
      end ;                                                                                                                   
    run ;                                                                                                                     
                                                                                                                              
                                                                                                                              
    Best regards                                                                                                              
                                                                                                                              
    *_         _     ____          _                      _                                                                   
    | |     __| |___|___ \   _ __ (_) ___ ___   ___  __ _| |                                                                  
    | |    / _` / __| __) | | '_ \| |/ __/ _ \ / __|/ _` | |                                                                  
    | |_  | (_| \__ \/ __/  | | | | | (_|  __/ \__ \ (_| | |                                                                  
    |_(_)  \__,_|___/_____| |_| |_|_|\___\___| |___/\__, |_|                                                                  
                                                       |_|                                                                    
    ;                                                                                                                         
                                                                                                                              
    Richard DeVenezia                                                                                                         
    rdevenezia@gmail.com                                                                                                      
                                                                                                                              
    The Hash Package FIND way in Proc DS2                                                                                     
                                                                                                                              
    proc ds2;                                                                                                                 
      data want / overwrite=yes;                                                                                              
        declare package hash h (                                                                                              
          [id], 0,                                                                                                            
          '{select id from have {options locktable=share} where income is null}',                                             
          '', '', '', ''                                                                                                      
        );                                                                                                                    
        method run();                                                                                                         
          set have(locktable=share) ;                                                                                         
          if h.find() ne 0;                                                                                                   
        end;                                                                                                                  
      enddata;                                                                                                                
    run;                                                                                                                      
    quit;                                                                                                                     
                                                                                                                              
    On the premise that LAG is less expensive than FIND the FIND could be coded to                                            
    occur only when the ID is not row-wise adjacent.  Works for disordered data                                               
                                                                                                                              
    data want (drop=_:);                                                                                                      
      if _n_ = 1 then do ;                                                                                                    
        dcl hash h (dataset:"have(where=(income is null))") ;                                                                 
        h.definekey ("id") ;                                                                                                  
        h.definedone () ;                                                                                                     
      end ;                                                                                                                   
      set have;                                                                                                               
      retain _keep_id;                                                                                                        
      if id ne lag(id) then do;                                                                                               
        _keep_id = h.check() ne 0;                                                                                            
      end;                                                                                                                    
      if _keep_id;                                                                                                            
    run;                                                                                                                      
                                                                                                                              
    An interesting but likely hefty SQL version would use EXCEPT                                                              
                                                                                                                              
    proc sql _method;                                                                                                         
      create table want                                                                                                       
      as select * from have                                                                                                   
      except                                                                                                                  
      select * from have                                                                                                      
      group by id                                                                                                             
      having count(*) ne n(income)                                                                                            
      ;                                                                                                                       
    quit;                                                                                                                     
                                                                                                                              
    *              _               _                                  _                                                       
     _ __ ___     | |__   __ _ ___| |__    _ __   ___  ___  ___  _ __| |_                                                     
    | '_ ` _ \    | '_ \ / _` / __| '_ \  | '_ \ / _ \/ __|/ _ \| '__| __|                                                    
    | | | | | |_  | | | | (_| \__ \ | | | | | | | (_) \__ \ (_) | |  | |_                                                     
    |_| |_| |_(_) |_| |_|\__,_|___/_| |_| |_| |_|\___/|___/\___/|_|   \__|                                                    
                                                                                                                              
    ;                                                                                                                         
                                                                                                                              
    Hi Team,                                                                                                                  
                                                                                                                              
    I know that it's "out of proper time" remark but I think for small sets                                                   
    (i.e. up to 75% of session's RAM) it can be done with just 1 data pass (even if not sorted)                               
                                                                                                                              
    all the best                                                                                                              
    Bart                                                                                                                      
                                                                                                                              
    data have ;                                                                                                               
      input id gender income ;                                                                                                
    cards;                                                                                                                    
    1  1  5000                                                                                                                
    1  1    42                                                                                                                
    1  1  7000                                                                                                                
    1  1     1                                                                                                                
    2  2  3000                                                                                                                
    2  2  5000                                                                                                                
    2  2  1000                                                                                                                
    3  1   .                                                                                                                  
    3  1  900000                                                                                                              
    3  1  12345                                                                                                               
    1  1     .                                                                                                                
    2  2  3001                                                                                                                
    2  2  5001                                                                                                                
    2  2  1001                                                                                                                
    ;                                                                                                                         
    run ;                                                                                                                     
    /* it's 3x14'000'000, so ~322MB */                                                                                        
    /*                                                                                                                        
    data have;                                                                                                                
      do _N_ = 1 to 1000000;                                                                                                  
        do POINT = 1 to nobs;                                                                                                 
          set have nobs=NOBS point=POINT;                                                                                     
          output;                                                                                                             
        end;                                                                                                                  
      end;                                                                                                                    
    stop;                                                                                                                     
    run;                                                                                                                      
    */                                                                                                                        
                                                                                                                              
    data _null_;                                                                                                              
      call symputx("_nobs_", nobs);                                                                                           
      stop;                                                                                                                   
      set have nobs=nobs;                                                                                                     
    run;                                                                                                                      
                                                                                                                              
    data want;                                                                                                                
      array ARR_ID     [&_nobs_] _temporary_;                                                                                 
      array ARR_GENDER [&_nobs_] _temporary_;                                                                                 
      array ARR_INCOME [&_nobs_] _temporary_;                                                                                 
      declare hash H();                                                                                                       
      H.defineKey("id");                                                                                                      
      H.defineDone();                                                                                                         
                                                                                                                              
      do until (END);                                                                                                         
        set have end=END curobs=CUROBS;                                                                                       
        ARR_ID     [CUROBS] = id;                                                                                             
        ARR_GENDER [CUROBS] = gender;                                                                                         
        ARR_INCOME [CUROBS] = income;                                                                                         
                                                                                                                              
        if missing(income) then _iorc_ = h.add();                                                                             
      end;                                                                                                                    
                                                                                                                              
      do curobs = 1 to &_nobs_;                                                                                               
        id = ARR_ID [CUROBS];                                                                                                 
                                                                                                                              
        if H.check() then                                                                                                     
        do;                                                                                                                   
          gender = ARR_GENDER [CUROBS];                                                                                       
          income = ARR_INCOME [CUROBS];                                                                                       
          output;                                                                                                             
        end;                                                                                                                  
      end;                                                                                                                    
      keep id gender income;                                                                                                  
    run;                                                                                                                      
                                                                                                                              
                                                                                                                              
    NOTE: There were 14000000 observations read from the data set WORK.HAVE.                                                  
    NOTE: The data set WORK.WANT has 6000000 observations and 3 variables.                                                    
    NOTE: DATA statement used (Total process time):                                                                           
          real time           4.97 seconds                                                                                    
          cpu time            4.88 seconds                                                                                    
                                                                                                                              
                                                                                                                              
                                                                                                                              
                                                                                                                              
                                                                                                                              
                                                                                                                              
