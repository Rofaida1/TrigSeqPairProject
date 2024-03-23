declare
  cursor seq_curs is 
    select sequence_name from user_sequences;

  cursor pk_curs is 
    select
      distinct ucc.column_name, ucc.table_name
    from
      user_constraints uc
    join
      user_cons_columns ucc on uc.constraint_name = ucc.constraint_name
    join
      user_tab_columns utc on ucc.column_name = utc.column_name
    join
      user_tables ut on ucc.table_name = ut.table_name
    left join
      user_cons_columns ucc2 on ucc2.table_name = ucc.table_name and ucc2.position = 2
    where
      uc.constraint_type = 'P'
      and utc.data_type = 'NUMBER'
      and ucc2.table_name is null;
  
  seqname varchar2(50); -- has the sequence name for each table
  max_id number(6);      -- has the maximum value for each table's primary key column

begin

  -- Drop existing sequences
  for seq_rec in seq_curs loop
    execute immediate 'DROP SEQUENCE ' || seq_rec.sequence_name;
  end loop;

  -- Create sequences based on primary key columns
  for pk_rec in pk_curs loop
    seqname := pk_rec.table_name || '_seq';
    
    -- Find the maximum value for the column
    execute immediate 'SELECT MAX(' ||pk_rec.column_name|| ') FROM ' || pk_rec.table_name into max_id;
    max_id := max_id + 1; 
    
    -- Create a sequence with the maximum value as the starting point and increment by 1
    execute immediate 'CREATE SEQUENCE ' || seqname ||' START WITH ' || max_id || ' INCREMENT BY 1 ';
 
    -- Create a trigger for each table
    execute immediate 'CREATE OR REPLACE TRIGGER ' || pk_rec.table_name || '_TRIG
                      BEFORE INSERT
                      ON ' || pk_rec.table_name|| '
                      REFERENCING NEW AS new OLD AS old
                      FOR EACH ROW
                      BEGIN
                        :new.' || pk_rec.column_name || ' := ' || seqname || '.nextval;
                      END;';
         
  end loop;

end;