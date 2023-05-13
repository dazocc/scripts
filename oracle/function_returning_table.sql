create or replace TYPE T_OBJECT_XPTO as object (
    NUMERO NUMBER(11,0),
    LINHA VARCHAR2(44)
);
/

create or replace TYPE T_TABLE_XPTO as table of T_OBJECT_XPTO;
/

create or replace function xpto return T_TABLE_XPTO is
    v_sql varchar2(4000);
    v_tabela T_TABLE_XPTO;
begin


   v_sql := 'select T_OBJECT_XPTO(X.NUM, X.LIN)
            from (
                select ''1'' num, ''test'' lin  from dual 
                union all
                select ''2'', ''test 2'' from dual) X';

    EXECUTE IMMEDIATE v_sql  bulk collect into v_tabela;

    return v_tabela;

end xpto;
/

select * from table(xpto());

drop type T_TABLE_XPTO;
drop type T_OBJECT_XPTO;
drop function xpto;
