1. SELECT aluno.matricula, usuario.nome FROM usuario INNER JOIN aluno ON (usuario.id = aluno.usuario_id);

2.  SELECT matricula, nome FROM usuario INNER JOIN aluno USING (usuario_id);  -- da errado pq as tabelas tem nome de coluna diferente.

3.  SELECT curso.id, curso.nome, aluno.matricula, usuario.nome, aluno.status FROM curso INNER JOIN aluno ON (curso.id = aluno.curso_id) INNER JOIN usuario ON (aluno.usuario_id = usuari
o.id);

4. SELECT requerimento.id, requerimento.aluno_matricula, requerimento.data_hora_abertura, requerimento.data_hora_encerramento, requerimento.status, tipo_requerimento_id FROM requerime
nto INNER JOIN tipo_requerimento ON (requerimento.tipo_requerimento_id = tipo_requerimento.id);

5. SELECT aluno.matricula, aluno.curso_id, aluno.status, requerimento.id, requerimento.data_hora_abertura, requerimento.status FROM aluno LEFT JOIN requerimento ON (aluno.matricula = requerimento.aluno_matricula);

6. SELECT aluno.matricula, aluno.curso_id, aluno.status, requerimento.id, requerimento.data_hora_abertura, requerimento.status FROM aluno LEFT JOIN requerimento ON (aluno.matricula = requerimento.aluno_matricula) WHERE requerimento.aluno_matricula IS NULL;

7. SELECT requerimento.id, requerimento.aluno_matricula, anexo.id, anexo.descricao FROM requerimento RIGHT JOIN anexo ON (requerimento.id = anexo.requerimento_id);

8. SELECT * FROM aluno FULL JOIN requerimento ON (aluno.matricula = requerimento.aluno_matricula);

9. SELECT tipo_requerimento.id, tipo_requerimento.descricao FROM tipo_requerimento LEFT JOIN requerimento ON (tipo_requerimento.id = requerimento.tipo_requerimento_id);

10. SELECT requerimento.tipo_requerimento_id, usuario.nome, aluno.matricula, requerimento.data_hora_abertura, requerimento.status FROM requerimento INNER JOIN aluno ON (requerimento.al
uno_matricula = aluno.matricula) INNER JOIN usuario ON (aluno.usuario_id = usuario.id);

11. SELECT usuario.id, usuario.nome, aluno.matricula, requerimento.status FROM usuario INNER JOIN aluno ON (usuario.id = aluno.usuario_id) INNER JOIN requerimento ON (aluno.matricula = requerimento.aluno_matricula) WHERE requerimento.status = 'EM ANÁLISE';

12. SELECT tipo_requerimento.id, requerimento.status, tipo_requerimento.descricao FROM tipo_requerimento INNER JOIN requerimento ON (tipo_requerimento.id = requerimento.tipo_requerimento_id) WHERE requerimento.status = 'INDEFERIDO';

13. SELECT aluno.matricula, usuario.nome, COUNT(requerimento.id) AS qtd_requerimentos FROM usuario INNER JOIN aluno On (usuario.id = aluno.usuario_id) LEFT JOIN requerimento ON (aluno.matricula = requerimento.aluno_matricula) GROUP BY aluno.matricula, usuario.nome ORDER BY qtd_requerimentos DESC;

14. SELECT usuario.id, usuario.nome, aluno.matricula, COUNT(requerimento.id) AS  qtd_requerimentos FROM usuario INNER JOIN aluno ON (usuario.id = aluno.usuario_id) INNER JOIN requerimento ON (aluno.matricula = requerimento.aluno_matricula) GROUP BY usuario.id, aluno.matricula HAVING COUNT(requerimento.id) > 5;

15. SELECT COALESCE(requerimento.id, 0) AS id, * FROM requerimento LEFT JOIN anexo ON requerimento.id = anexo.requerimento_id;

16. SELECT usuario.id, usuario.nome, aluno.matricula, usuario.email, usuario.cpf FROM usuario LEFT JOIN aluno ON (usuario.id = aluno.usuario_id);

17. SELECT curso.id, curso.nome, curso.turno, aluno.matricula, aluno.status FROM curso RIGHT JOIN aluno ON (curso.id = aluno.curso_id);

18. SELECT requerimento.id, requerimento.aluno_matricula, requerimento.status, requerimento.tipo_requerimento_id, anexo.id AS id_anexo, anexo.descricao FROM requerimento INNER JOIN anex
o ON (requerimento.id = anexo.requerimento_id);

19. SELECT aluno.matricula, aluno.status, requerimento.tipo_requerimento_id, requerimento.status FROM aluno FULL JOIN requerimento ON (aluno.matricula = requerimento.aluno_matricula);

20.  SELECT * FROM requerimento JOIN tipo_requerimento USING (tipo_requerimento);

36. SELECT  requerimento.status, COUNT(*) AS qtd_requerimentos FROM requerimento GROUP BY requerimento.status;

37. SELECT tipo_requerimento.id, tipo_requerimento.descricao, COUNT(*) AS qtd FROM tipo_requerimento INNER JOIN requerimento ON (tipo_requerimento.id = requerimento.tipo_requerimento_id) GROUP BY tipo_requerimento.id, tipo_requerimento.descricao HAVING COUNT(*) > 0;

38. SELECT aluno.matricula, aluno.curso_id, aluno.status, COUNT(*) AS red_por_aluno FROM requerimento LEFT JOIN aluno ON (requerimento.aluno_matricula = aluno.matricula) GROUP BY aluno.matricula, aluno.curso_id, aluno.status;

39. SELECT EXTRACT(YEAR FROM requerimento.data_hora_abertura) AS ano, COUNT(*) qtd_requerimentos FROM requerimento GROUP BY ano;

40. SELECT * FROM requerimento WHERE EXTRACT(MONTH FROM data_hora_abertura) = EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM data_hora_abertura) = EXTRACT(YEAR FROM CURRENT_DATE);

41. select avg(duracao)::float as media_horas_duracao from curso;

42. select * from curso where duracao > (select cast(avg(duracao) as float) as media_horas_duracao from curso);

43. SELECT aluno.matricula, COUNT(*) AS qtd_requerimentos FROM requerimento INNER JOIN aluno ON (requerimento.aluno_matricula = aluno.matricula) WHERE data_hora_encerramento IS NULL GROUP BY aluno.matricula HAVING COUNT(*) > 1;

44. SELECT aluno.matricula, COUNT(*) AS qtd_requerimento FROM requerimento INNER JOIN aluno ON (requerimento.aluno_matricula = aluno.matricula) GROUP BY aluno.matricula HAVING COUNT(*) > 1 ORDER BY qtd_requerimento DESC LIMIT 
1;

45. SELECT EXTRACT(YEAR FROM data_hora_abertura) AS ano, COUNT(*) AS qtd_ano FROM requerimento GROUP BY ano;

46. SELECT EXTRACT(MONTH FROM data_hora_abertura) AS mes, COUNT(*) AS qtd FROM requerimento WHERE EXTRACT(YEAR FROM data_hora_abertura) = EXTRACT(YEAR FROM CURRENT_DATE) GROUP BY EXTRACT(MONTH FROM data_hora_abertura) ORDER BY
mes;

47. SELECT AVG(qtd) AS media_por_aluno FROM (SELECT COUNT(aluno_matricula) as qtd FROM requerimento GROUP BY aluno_matricula);

48. SELECT tipo_requerimento.id, COUNT(*) AS qtd FROM tipo_requerimento INNER JOIN requerimento ON (tipo_requerimento.id = requerimento.tipo_requerimento_id) GROUP BY tipo_requerimento.id ORDER BY qtd DESC;

49. SELECT tipo_requerimento.id, COUNT(*) AS qtd FROM tipo_requerimento INNER JOIN requerimento ON (tipo_requerimento.id = requerimento.tipo_requerimento_id) GROUP BY tipo_requerimento.id  HAVING COUNT(*) > 1;

50. SELECT requerimento.id, COUNT(anexo.id) AS qtd_anexos FROM requerimento LEFT JOIN anexo ON anexo.requerimento_id = requerimento.id GROUP BY requerimento.id HAVING COUNT(anexo.id) > 0;

51. SELECT EXTRACT(YEAR FROM requerimento.data_hora_encerramento) AS ano_encerramento, COUNT (*) FROM requerimento WHERE data_hora_encerramento IS NOT NULL GROUP BY ano_encerramento;

52. SELECT status, COUNT(*) as qtd FROM requerimento GROUP BY status ORDER BY COUNT(*) DESC;

53.SELECT curso.id, curso.nome, curso.turno, COUNT(aluno.curso_id) AS qtd_alunos FROM curso INNER JOIN aluno ON (curso.id = aluno.curso_id) GROUP BY curso.id, curso.nome,curso.turno;

54. SELECT curso.id, curso.nome, curso.turno, COUNT(aluno.curso_id) AS qtd_alunos FROM curso INNER JOIN aluno ON (curso.id = aluno.curso_id) GROUP BY curso.id, curso.nome,curso.turno HAVING COUNT(aluno.curso_id) > 2;

55. SELECT aluno.matricula, COUNT(DISTINCT EXTRACT(YEAR FROM data_hora_abertura)) AS qtd_anos FROM aluno INNER JOIN requerimento ON aluno.matricula = requerimento.aluno_matricula GROUP BY aluno.matricula HAVING COUNT(DISTINCT EXTRACT(YEAR FROM data_hora_abertura)) > 1;

56. select * from requerimento where cast(data_hora_abertura as date) = current_date;

58.select * from requerimento where data_hora_abertura::date >= current_date - interval '30 days';

59.select 
    id,
    aluno_matricula,
    status,
    to_char(data_hora_abertura, 'dd/mm/yyyy HH24:MI'),     
    case 
        when extract(dow from data_hora_abertura) = 0 then 'Domingo'
                when extract(dow from data_hora_abertura) = 1 then 'Segunda'
                                when extract(dow from data_hora_abertura) = 2 then 'Terça'
                                                when extract(dow from data_hora_abertura) = 3 then 'Quarta'
                                                                when extract(dow from data_hora_abertura) = 4 then 'Quinta'
                                                                                when extract(dow from data_hora_abertura) = 5 then 'Sexta'
                                                                                                when extract(dow from data_hora_abertura) = 6 then 'Sábado' end as dia_da_semana from requerimento;

60. SELECT id, nome, email, extract(year from age(data_nascimento)) as idade FROM usuario;

61. SELECT * FROM requerimento WHERE data_hora_abertura::DATE >= CURRENT_DATE - INTERVAL '7 days';

62. SELECT * FROM requerimento WHERE EXTRACT(YEAR FROM data_hora_abertura) = EXTRACT(YEAR FROM CURRENT_DATE);

63. SELECT * FROM requerimento WHERE EXTRACT(MONTH FROM data_hora_abertura) = EXTRACT(MONTH FROM CURRENT_DATE);

64. SELECT * FROM requerimento WHERE EXTRACT(MONTH FROM data_hora_abertura) = EXTRACT(MONTH FROM CURRENT_DATE);

65. SELECT * FROM requerimento WHERE EXTRACT(MONTH FROM data_hora_abertura) = EXTRACT(MONTH FROM CURRENT_DATE);

66. select id,case when extract(dow from data_hora_abertura) = 0 then 'Domingo'
        when extract(dow from data_hora_abertura) = 1 then 'Segunda' 
        -- 
        -- fazer para demais dias
        --
        when extract(dow from data_hora_abertura) = 2 then 'Terça'
        when extract(dow from data_hora_abertura) = 3 then 'Quarta'
    else
        'dia que n fiz por preguiça'
    end as dia_da_semana
from requerimento order by id;

67. SELECT id, aluno_matricula, to_char(data_hora_abertura::date, 'DD/MM/YYYY') AS data_abertura, to_char(data_hora_encerramento::date, 'dd/mm/yyyy') AS data_encerramento, status FROM r
equerimento;

68. SELECT id, nome, email, EXTRACT(YEAR FROM age(data_nascimento)) AS idade FROM usuario;

69. SELECT *
FROM requerimento WHERE status = 'EM ANÁLISE' AND NOW() - data_hora_abertura > INTERVAL '30 days';

70. SELECT id, data_abertura from requerimento where data_hora_abertura in (max(data_hora_abertura), min(data_hora_abertura));

71. SELECT nome FROM usuario WHERE nome ILIKE 'I%';

72. SELECT nome FROM usuario WHERE UPPER(nome) ILIKE 'I%';

73. SELECT nome FROM usuario WHERE LOWER(nome) ILIKE 'I%';

74. select nome, length(trim(nome)) AS tamanho_nome from usuario;

75. select nome||' '||email from usuario;
select concat(nome,' ',email) from usuario;

76. select nome, cpf, substr(cpf,1, 3)||'.'||substr(cpf,4,3)||'.'||substr(cpf,7,3)||'-'||substr(cpf, 10,2) from usuario

77. SELECT replace(lower(nome), 'igor', 'rogerio') from usuario;

79. select initcap(nome) from usuario;

81. select email, substr(email, 1, strpos(email, '@')-1) from usuario;

    select split_part(email, '@', 1) from usuario;

82. select lpad(cpf, 11, '0') from usuario;

83. select rpad(nome, 30, ' ') from usuario;

    select length(rpad(nome, 30, ' ')), length(nome) from usuario;

84. SELECT replace(nome, ' ', '_') from usuario;

85. select substr(nome, 1, 3) from usuario;

86.
select * from aluno inner join usuario on (aluno.usuario_id = usuario.id) where matricula in(select aluno_matricula from requerimento group by aluno_matricula);

SELECT * FROM aluno tab1 WHERE EXISTS (SELECT * FROM requerimento WHERE requerimento.aluno_matricula = tab1.matricula);

select * from aluno where matricula in(select aluno_matricula from requerimento group by aluno_matricula);


