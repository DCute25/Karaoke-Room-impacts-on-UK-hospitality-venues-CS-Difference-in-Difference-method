# Project's Title
  CS Difference-in-Difference empirical analysis: Karaoke Room impacts on UK hospitality venues' return on assets
  
## Introduction
  This code is accompanied for the bachelor thesis "Advancing Applicability Of Difference-In-Difference Methods Applicability In Non-Experimental Settings:  An empirical analysis of karaoke's impact on hospitality venues’ return on assets in the UK"
## File and directory structure

  **Contents of the different directories**
  
    - Directory 'code' includes:
        + STATA code file 'karaoke_roa.do'

    - Directory 'data' includes:
        + Studied venues data file 'karaoke_room_checked.csv'
        
    - Directory 'document' includes:
        + The complete Bachelor's thesis " Advancing Applicability Of Difference-In-Difference Methods Applicability In Non-Experimental Settings:  An empirical analysis of karaoke's impact on hospitality venues’ return on assets in the UK"
       
  **Contents of README files**
  
    - The README file describes:
        + Project information
        + User instruction
    

## Installation instructions

    - The program requires the csdid package
    - Install it by typing ssc install csdid

## User instructions

  **The program is executed by running the file 'karaoke_roa.do', which utilizes the data from file 'karaoke_room_checked.csv'**

  After installing the csdid package, set up the working space:
  
    - Change to the directory that stores the data file 'karaoke_room_checked.csv':
        + cd "your directory"
        
    - Import the data file:
        + import delimited "karaoke_room_checked.csv", clear

    - Check for any duplicates in the panel data for the code to run smoothly
        + Code section ***Check for duplicate in panel data
          
  **The supporting graphs and tables used in the thesis are ontained as follow**
  
    - The Figure 2 in the thesis, Parallel trend test, is obtained from:
        + Code section ***Visualization for parallel trend assumpion test

    - The Figure 3 in the thesis, Karaoke Group-Time average treatment effects, is obtained from:
        + Code section ***Visualize Group-Time Average Treatment Effects - Unconditional parallel trend 
        + Code section ***Visualize Group-Time Average Treatment Effects - Conditional parallel trend

    - The Table 4 in the thesis, aggregated treatment effect, is obtained from:
        + Code section ***Without covariates (uncodnitional parallel trend assumptions)
        + Code section ***With covariates (conditional parallel trend assumptions)
      
      All generated graphs are automatically saved in the users' working directory.
      
