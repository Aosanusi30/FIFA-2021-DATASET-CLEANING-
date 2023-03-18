# FIFA-2021-DATASET-CLEANING
## #Datacleaningchallenge
![](FIFAIMG.jpg)

# INTRODUCTION 
Data cleaning challenge #datacleaningchallenge was organized by Promise Nonso and Victor Somadina amongst other professional in the data industry. The challenge was organized for both newbies and professionals where we all collaborated to help each other learn and grow. The main medium of communication was telegram which accommodated about 2000 people from all over the world. All data enthusiast beginner, intermediate and expert all came together dedicating their time to anybody who has challenges in cleaning the data. Participant was encouraged to use the tool he/she knows how to use in other to perfect his/her skills and tools such as Excel, Power BI, SQL, Python, R and Google sheets were used and different subgroups was created using Telegram.

# ABOUT THE DATASET 
The FIFA 2021 dataset was originally gotten from [Kaggle.com](https://www.kaggle.com/datasets/yagunnersya/fifa-21-messy-raw-dataset-for-cleaning-exploring) and it contains information about **18,979** football players and **77** columns. Some of the columns are ID, Name, LongName, Age, Nationality. The dataset also has a data dictionary to familiarize with the date before cleaning. 

# BACKGROUND 
The dataset was from [Kaggle.com](https://www.kaggle.com/datasets/yagunnersya/fifa-21-messy-raw-dataset-for-cleaning-exploring) it was a messy data that needs to be cleaned before any analysis can be done. The data dictionary was used in familiarizing with the data. During the data cleaning or cleansing process, I detect corrupt, inaccurate, incomplete, irrelevant parts in records of the data, and also replace and modify the coarse data. To me, filter is an eye in seeing what is in the data. We can’t scroll around thousands of rows; so that best thing is to check using the filter; which row is cleaned and not. Filter is one of the best tools when it comes to data cleaning.

The dataset consists of 18,979 records and 77 columns and after the data cleansing the records are **189,978 and 78 fields** because some fields have to be modified like the **Contract**, to have the **Agreement Type** and the **Contract Duration** while the **Positions** the **No of positions** played. This can be used when you want to analysis the data and have insight on how many position has he never played for the club and which position is he good at. The M Language was used and conditional column to clean the data in **Power BI**.  
 
# PROJECT OBJECTIVE 
The main aim of this project is data cleaning and made available the data for analysis. 

**What to look out for in the data** 
1.	Incorrect Data type 
2.	Spelling Errors and values 
3.	Duplicate entry
4.	Null entries 
5.	Irrelevant data 
6.	Unnecessary symbols in the column headings 

# CLEANING PROCESS 
**_Note:_** _Before the cleaning of the dataset, I backup the original file in a safe place in case of errors in the working dataset_. 

1.	**_Data Extracting:_** The data was sent into the telegram group chat and a reference to the site for more insight in on the dataset. The data was download as a Common Separated Value (CSV) along with the data dictionary. And the data dictionary was read to have full understanding of what the dataset is all about. And data was imported into Power BI for cleaning 

2. **_Data Exploration:_** The data was viewed and a lot of errors, inaccuracy and inconsistency was discovered in the data e.g. the Name, LongName, Wages, Value, Release Clause column etc. has non-printed characters, inappropriate datatype  
![](screenshotofuncleandata.JPG)

3.	**_Data Cleaning:_** In other to make this dataset ready and available for analysis, the step-by-step process used in cleaning the dataset is prescribed below. 

   -	**_Club:_** After the Importing the Dataset into Power BI, in the Power Query Mode, there was much space between the rows that needs to be cleaned and the club column  was the source of this. So, my first step was to trim the club column. And it was done by clicking on **Transform**, **Navigating to format** and **clicking on Trim** 


| Before | After|
|:--------------------:|--------------------:|
|  ![](BeforeClub.JPG) | ![](AfterClubs.JPG) |

- 
