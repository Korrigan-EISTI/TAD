# Using GLPI database on your computer

<br>

## How to deploy GLPI database on your computer

After setting up an Oracle Database on your computer, you first need to connect to _system_ and run :

1) `user.sql`

<br>

Then connect to _glpiAdmin_ with the password _glpiAdmin_

<br>

Finally run the sql scripts in the following order :

2) `cluster.sql`
3) `init.sql`
4) `index.sql`
5) `view.sql`
6) `sequence.sql`
7) `procedure.sql`
8) `trigger.sql`

<br>

## How to cancel the deployment of GLPI database on your computer

Simply connect to _system_ and run `cancel.sql`

## Temp (on school laptop):

@"C:\Users\CYTech Student\TAD\user.sql"

Connect glpiAdmin
mdp: glpiAdmin

@"C:\Users\CYTech Student\TAD\sequence.sql"
@"C:\Users\CYTech Student\TAD\cluster.sql"
@"C:\Users\CYTech Student\TAD\init.sql"
@"C:\Users\CYTech Student\TAD\index.sql"
@"C:\Users\CYTech Student\TAD\procedure.sql"
@"C:\Users\CYTech Student\TAD\role.sql"
@"C:\Users\CYTech Student\TAD\trigger.sql"
@"C:\Users\CYTech Student\TAD\view.sql"

@"C:\Users\CYTech Student\TAD\Cergy\views_cergy.sql"
@"C:\Users\CYTech Student\TAD\Cergy\trigger_cergy.sql"
@"C:\Users\CYTech Student\TAD\Pau\views_pau.sql"
@"C:\Users\CYTech Student\TAD\Pau\trigger_pau.sql"

alter session set "_ORACLE_SCRIPT"=true;

@"C:\Users\CYTech Student\TAD\data_users.sql"
@"C:\Users\CYTech Student\TAD\data_entities.sql"