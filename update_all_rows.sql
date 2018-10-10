 DELIMITER %%
  CREATE PROCEDURE updateTable(IN ids INT) BEGIN
UPDATE table_name
SET tax =   -- set to what ever you want to update
  (SELECT *    
   FROM
     (SELECT amount - ROUND(amount / 1.2, 2)
      FROM `table_name` AS tax
      WHERE id = ids) AS tax)
WHERE id = ids
  AND tax!="0.00"; END 
  %%
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE update_all_rows()

   BEGIN
      DECLARE a INT Default 1 ;
      DECLARE field_length int;

      select max(id) into field_length from table_name;

      simple_loop: LOOP
         SET a=a+1;

         call updateTable(a);

         IF a >= field_length THEN
            LEAVE simple_loop;
         END IF;
   END LOOP simple_loop;
END $$
DELIMITER ;