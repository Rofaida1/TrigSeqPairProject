# TrigSeqPairProject
This script is designed to automate the generation of sequences and triggers for Oracle databases. It facilitates the creation of sequences and associated triggers based on primary key columns in specified tables.

1- Purpose
In Oracle databases, sequences are commonly used to generate unique numeric identifiers for tables. Additionally, triggers can be employed to automatically populate these identifiers upon insertions into tables. This script streamlines the process of creating sequences and triggers for tables with primary key columns of data type 'NUMBER'.

2- Prerequisites
- Oracle Database
- User with appropriate privileges to create sequences and triggers
  
3- Instructions -
Set up Cursors: The script declares two cursors:

- seq_curs: Retrieves the names of existing sequences owned by the current user.
- pk_curs: Identifies distinct primary key columns in tables, ensuring they are of data type 'NUMBER'.
- Drop Existing Sequences: Iterates through existing sequences obtained from seq_curs and drops them using dynamic SQL.

- Create Sequences and Triggers: Loops through primary key columns fetched by pk_curs:
- Generates a sequence name based on the table name.
- Determines the maximum value of the primary key column.
- Creates a new sequence starting from the maximum value plus one.
- Generates a trigger associated with the table, which automatically assigns the next sequence value to the primary key column upon insertion.
- Execute the Script: Run the script in an Oracle environment to generate sequences and triggers as specified.

4- Usage
- Open your preferred Oracle Database management tool (e.g., SQL*Plus, SQL Developer).

C- onnect to the Oracle Database using a user account with appropriate privileges.

- Copy and paste the script into the SQL editor.

- Execute the script to create sequences and triggers.

5- Important Notes
- Ensure that the user executing the script has the necessary permissions to create sequences and triggers.
- Verify the correctness of primary key columns and their associated data types before executing the script.
- It's recommended to review and customize the script according to specific database requirements before deployment.
