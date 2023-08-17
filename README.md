# ⛩️ Meta Database Engineering Capstone ⛩️

## **Introduction**
The penultimate course within the Meta Database Engineering looks to combine various themes and common tasks for Database Creation and Management. Following the database and enviornent set-up, the project concludes with the use of **Tableau** to visualize our data!

<br>

### `Tasks Performed & Tools Used` 🧰


`Project Setup` 🖇️
* Create **MySQL** instance server in `MySQL Workbench` and create ERD Diagram model and **forward engineer** into created instance
* Set up dedicated Git repository for project materials
* Mock Pull Request acceptance by creating separate branch to commit sql schema deliverables created in Workbench
* Update Primary Branch w/Pull from main branch following Merge of created pull request in repository
* **Repository Location** : [Project Setup](/ProjectSetup)

<br>

`Procedures, Views, Prepared Statements` 🌄
* Implement transaction procedure to manage table booking within created database schema
* Create `View` for Database joining details of tables in schema
* Join related tables for potential business request of Order threshold 
    - [Virtual Table Exercises](/Procedures_Prepared_Stms/VirtualTableExercise.sql)
* Procedures : The Section had heavy emphasis on procedures that could run for database integrity checks 
    - User Sales Metrics, Order Detail, Customer Actions
    - [Procedure & Integrity Checks](/Procedures_Prepared_Stms/Procedures_Prepared_Optimization.sql)

<br>

`Table Booking System : A lot more Procedures & Transactions!` 📚
* Procedures with UserInput 
    - **Check Booking** with user generated values for procedures to conditionally return booking availability 
    - **Add Valid Booking** commit and rollback logic for creating rows in Bookings based on submitted customer and booking details for booking request
    - [Commit & Rollback for Prepared Statements](/Procedures_Prepared_Stms/UserInput_AvblBookings.sql)

* Further Procedures for CRUD Style Management
    - Add, Update, and Delete
    - Each has conditional logic for type operations with a similar output string returned for action commited by each called procedure
    - [CRUD Statements](/Procedures_Prepared_Stms/Add_UpdateBks.sql)

<br>

`Clients & Visualization` 💹
* Implement a database client and visualize data using Tableau
* Client : https://github.com/craigtrupp/db-capstone-project/blob/main/DatabaseClient/DBClient.ipynb
* **Tableau** Public Profile, Workbook and Data Extract
    - https://public.tableau.com/app/profile/craig.rupp
    - [Tableau Items](/Tableau_Items)

