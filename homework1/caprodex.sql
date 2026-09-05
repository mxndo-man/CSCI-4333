SELECT S.super 
FROM  emp-super as T, emp-super as S
WHERE T.person = 'bob' and T.super = S.person;
